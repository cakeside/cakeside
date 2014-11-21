json.cakes @cakes do |cake|
  json.cache! ['v2', cake] do
    json.partial! 'cake', cake: cake
  end
end
json.meta do
  json.total_pages @cakes.total_pages
end
