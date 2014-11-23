json.photos @photos do |photo|
  json.cache! ['v2', photo] do
    json.partial! photo, photo: photo
  end
end
json.meta do
  json.partial! 'api/v2/shared/pagination', items: @photos
end
