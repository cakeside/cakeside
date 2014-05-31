class UploadPhoto
  def initialize(message_bus = Spank::IOC.resolve(:message_bus))
    @message_bus = message_bus
  end

  def run(cake_id, params)
    photo = Creation.find(cake_id).photos.create!(image_processing: true)
    system "mkdir -p #{Rails.root.join("tmp/uploads/")}"
    original_path = params[:image].path
    new_path = "#{Rails.root.join("tmp", "uploads")}/#{SecureRandom.uuid}#{File.extname(params[:image].original_filename)}"
    FileUtils.mv(original_path, new_path)
    message = {
      cake_id: cake_id,
      photo_id: photo.id,
      file_path: new_path,
      original_filename: params[:image].original_filename,
      content_type: params[:image].content_type,
    }
    @message_bus.publish(:upload_photo, message)
    map_from(photo.id, params[:image].original_filename)
  end

  private

  def map_from(photo_id, name)
    {
      name: name,
      url: "/_default.png",
      thumbnail_url: "/assets/thumb_default.png",
      delete_url: photo_id,
      delete_type: "DELETE"
    }
  end
end
