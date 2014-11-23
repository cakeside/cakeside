json.cache! ['v1', profile] do
  json.id profile.id
  json.email profile.email
  json.name profile.name
  json.website profile.website
  json.twitter profile.twitter
  json.facebook profile.facebook
  json.city profile.city
  json.errors profile.errors
end
