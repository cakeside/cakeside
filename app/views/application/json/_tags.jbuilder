json.cache! items do
  json.array! items do |tag|
    json.id tag.id
    json.name tag.name
    json.count tag.taggings_count
  end
end
