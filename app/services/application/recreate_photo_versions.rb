class RecreatePhotoVersions < Struct.new(:photo_id)
  def perform
    photo = Photo.find(photo_id)
    photo.image.recreate_versions!
  end
end
