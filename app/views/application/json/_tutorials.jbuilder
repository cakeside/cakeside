json.cache! items do
  json.array! items do |tutorial|
    json.id tutorial.id
    json.heading tutorial.heading
    json.description tutorial.description
    json.url tutorial.url
    json.image_url tutorial.image_url
    json.author tutorial.author
    json.author_url tutorial.author_url
    json.created_at tutorial.created_at
    json.updated_at tutorial.updated_at
    json.tags tutorial.tags do |tag|
      json.name tag.name
    end
  end
end
