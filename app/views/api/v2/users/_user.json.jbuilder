json.cache! ['v2', user] do
  json.id user.id
  json.name user.name
  json.createdAt user.created_at
  json.updatedAt user.updated_at
end
