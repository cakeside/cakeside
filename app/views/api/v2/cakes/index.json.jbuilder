json.cakes @cakes do |cake|
  json.partial! 'cake', cake: cake
end
json.users @cakes.map(&:user) do |user|
  json.partial! user, user: user
end
json.photos @cakes.map { |x| x.photos }.flatten do |photo|
  json.partial! photo, photo: photo
end
json.categories Category.all do |category|
  json.partial! category, category: category
end
json.meta do
  json.totalPages @cakes.total_pages
  json.total_pages @cakes.total_pages
end
