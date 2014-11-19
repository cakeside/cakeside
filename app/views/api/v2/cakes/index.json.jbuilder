json.cakes @cakes do |cake|
  json.id cake.id
  json.name cake.name
  json.description cake.story
  json.created_at cake.created_at
  json.updated_at cake.updated_at
end
