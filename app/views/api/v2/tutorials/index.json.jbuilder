json.tutorials @tutorials do |tutorial|
  json.heading tutorial.heading
  json.description tutorial.description
  json.url tutorial.url
  json.image_url tutorial.image_url
  json.submitter tutorial.user.id
end
