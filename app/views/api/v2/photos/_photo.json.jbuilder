json.id photo.id
json.thumbUrl photo.url_for(:thumb)
json.largeUrl photo.url_for(:large)
json.originalUrl photo.url_for(:original)
json.createdAt photo.created_at
json.updatedAt photo.updated_at
