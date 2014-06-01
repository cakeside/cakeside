class ProcessPhoto
  def initialize(photos = Photo)
    @photos = photos
  end

  def handles?(event)
    :upload_photo == event
  end

  def handle(message)
    file = File.open(message[:file_path])
    photo = @photos.find(message[:photo_id])
    photo.image = file
    photo.image_processing = false
    photo.content_type = message[:content_type]
    photo.original_filename = message[:original_filename]
    photo.latitude, photo.longitude = parse_exif_from(file)
    photo.save!
  end

  private

  def parse_exif_from(file)
    exif = EXIFR::JPEG.new(file)
    [exif.gps.latitude, exif.gps.longitude]
  end
end
