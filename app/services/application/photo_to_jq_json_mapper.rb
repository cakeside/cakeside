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
