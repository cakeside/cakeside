class UploadPhoto
  def initialize(message_bus = Spank::IOC.resolve(:message_bus), cakes = Creation)
    @message_bus = message_bus
    @cakes = cakes
  end

  def run(cake_id, params)
    photo = @cakes.find(cake_id).photos.create!(image_processing: true, watermark: params[:watermark])
    @message_bus.publish(:upload_photo, create_message_from(cake_id, params, photo))
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

  def move_to_temporary_storage(temp_file_path, original_filename)
    new_path = "#{create_tmp_dir}/#{original_filename}"
    FileUtils.mv(temp_file_path, new_path)
    new_path
  end

  def create_tmp_dir
    directory = Rails.root.join("tmp/uploads/#{SecureRandom.uuid}")
    system "mkdir -p #{directory}"
    directory
  end

  def create_message_from(cake_id, payload, photo)
    {
      cake_id: cake_id,
      photo_id: photo.id,
      file_path: move_to_temporary_storage(payload[:image].path, payload[:image].original_filename),
      original_filename: payload[:image].original_filename,
      content_type: payload[:image].content_type,
    }
  end
end
