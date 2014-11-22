json.cache! ['v2', tutorial] do
  json.id tutorial.id
  json.heading tutorial.heading
  json.description tutorial.description
  json.url tutorial.url
  json.imageUrl tutorial.image_url
  json.submitter tutorial.user.id
end
