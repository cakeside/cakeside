class UploadPhoto
  def initialize(message_bus = Spank::IOC.resolve(:message_bus), mapper = PhotoToJQJsonMapper.new)
    @message_bus = message_bus
    @mapper = mapper
  end

  def run(cake_id, params)
    photo = Creation.find(cake_id).photos.create!(image_processing: true)
    message = {
      cake_id: cake_id,
      photo_id: photo.id,
      file_path: params[:image].tempfile.path,
      original_filename: params[:image].original_filename,
      content_type: params[:image].content_type,
      headers: params[:image].headers
    }
    @message_bus.publish(:upload_photo, message)
    map_from(photo)
  end

  private

  def map_from(photo)
    @mapper.map_from(photo)
  end
end

class PhotoToJQJsonMapper
  def map_from(photo)
    {
      name: photo.read_attribute(:image),
      url: photo.image.url,
      thumbnail_url: photo.is_processed? ? photo.image.thumb.url : photo.image.thumb.default_url,
      delete_url: photo.id,
      delete_type: "DELETE"
    }
  end
end
