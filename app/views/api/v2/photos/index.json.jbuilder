json.photos @photos do |photo|
  json.cache! ['v2', photo] do
    json.partial! photo, photo: photo
  end
end
json.meta do
  json.totalPages @photos.total_pages
end
