json.id cake.id
json.name cake.name
json.description cake.story
json.author cake.user.id
json.photos cake.photos.pluck(:id)
json.createdAt cake.created_at
json.updatedAt cake.updated_at
