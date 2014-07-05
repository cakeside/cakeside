json.id cake.id
json.name cake.name
json.slug cake.to_param
json.story cake.story
json.watermark cake.watermark
json.category do
  json.id cake.category.id
  json.name cake.category.name
end
json.user do
  json.id cake.user.id
  json.name cake.user.name
end
json.created_at cake.created_at
json.updated_at cake.updated_at
json.photos cake.photos do |photo|
  json.id photo.id
  json.large_url "https:#{photo.url_for(:large)}"
  json.thumb_url "https:#{photo.url_for(:thumb)}"
  json.created_at photo.created_at
  json.updated_at photo.updated_at
end
json.tags cake.tags do |tag|
  json.name tag.name
end
