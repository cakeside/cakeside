class ProcessPhoto
  def initialize(photos = Photo)
    @photos = photos
  end

  def handles?(event)
    :upload_photo == event
  end

  def handle(message)
    photo = @photos.find(message[:photo_id])
    photo.image = File.open(message[:file_path])
    photo.image_processing = false
    photo.content_type = message[:content_type]
    photo.original_filename = message[:original_filename]
    photo.save!
  end
end
