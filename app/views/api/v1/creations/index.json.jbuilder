json.array! @creations do |creation|
  json.id creation.id
  json.name creation.name
  json.user do
    json.name creation.user.name
  end
  json.photo "http:#{creation.photos.first.image.thumb.url}"
  json.photos creation.photos do |photo|
    json.url "http:#{photo.image.thumb.url}"
  end
end
