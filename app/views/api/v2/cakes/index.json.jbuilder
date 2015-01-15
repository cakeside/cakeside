json.cakes @cakes do |cake|
  json.partial! 'cake', cake: cake
end
json.users @cakes.map(&:user) do |user|
  json.partial! user, user: user
end
json.photos @photos do |photo|
  json.partial! photo, photo: photo
end
json.categories @categories do |category|
  json.partial! category, category: category
end
json.meta do
  json.partial! 'api/v2/shared/pagination', items: @cakes
end
