json.cake do
  json.partial! 'cake', cake: @cake
end
json.users [@cake.user] do |user|
  json.partial! user, user: user
end
json.photos @cake.photos do |photo|
  json.partial! photo, photo: photo
end
json.categories [@cake.category] do |category|
  json.partial! category, category: category
end
