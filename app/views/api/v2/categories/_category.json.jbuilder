json.cache! ['v2', category] do
  json.id category.id
  json.name category.name
  json.slug category.slug
  json.createdAt category.created_at
  json.updatedAt category.updated_at
end
