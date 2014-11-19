json.cakes @cakes do |cake|
  json.cache! ['v2', cake] do
    json.partial! 'cake', cake: cake
  end
end
