json.cache! items do
  json.array! items do |category|
    json.id category.id
    json.name category.name
    json.slug category.slug
  end
end
