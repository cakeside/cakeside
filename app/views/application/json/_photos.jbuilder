json.array! @photos do |photo|
  json.cache! ['v1', photo] do
    json.id photo.id
    json.cake_id photo.imageable_id
    json.content_type photo.content_type
    json.original_filename photo.original_filename
    json.thumb_url photo.url_for(:thumb)
    json.large_url photo.url_for(:large)
    json.original_url photo.url_for(:original)
    json.created_at photo.created_at
    json.updated_at photo.updated_at
  end
end
