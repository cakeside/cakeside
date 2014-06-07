class PhotoToJQJsonMapper
  def map_from(photo)
    {
      name: photo.image,
      url: photo.url_for(:large),
      thumbnail_url: photo.url_for(:thumb),
      delete_url: photo.id,
      delete_type: "DELETE"
    }
  end
end
