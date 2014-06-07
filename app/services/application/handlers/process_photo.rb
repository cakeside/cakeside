class ProcessPhoto
  def initialize(photos, blob_storage = BlobStorage.new)
    @photos = photos
    @blob_storage = blob_storage
  end

  def handles?(event)
    :upload_photo == event
  end

  def handle(message)
    photo = @photos.find(message[:photo_id])
    photo.upload(message[:file_path], @blob_storage)
    photo.save!
  end
end
