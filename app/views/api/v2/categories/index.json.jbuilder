json.categories @categories do |category|
  json.partial! category, category: category
end
