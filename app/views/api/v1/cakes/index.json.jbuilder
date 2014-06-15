json.array! @cakes do |cake|
  json.partial! 'cake', cake: cake
end
