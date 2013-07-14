json.array! @creations do |creation|
  json.name creation.name
  json.user do
    json.name creation.user.name
  end
  json.photos creation.photos do |photo|
    json.url url_for(photo.image_url)
  end
end
