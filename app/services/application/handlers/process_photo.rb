class ProcessPhoto
  def initialize(photos, exif_parser, blob_storage = BlobStorage.new)
    @photos = photos
    @exif_parser = exif_parser
    @blob_storage = blob_storage
  end

  def handles?(event)
    :upload_photo == event
  end

  def handle(message)
    photo = @photos.find(message[:photo_id])
    photo.image_processing = nil
    photo.latitude, photo.longitude = @exif_parser.parse_geolocation_from(message[:file_path])
    photo.upload(message[:file_path], @blob_storage)
    photo.save!
  end
end
