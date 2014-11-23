json.users @users do |user|
  json.partial! user, user: user
end
json.meta do
  json.partial! 'api/v2/shared/pagination', items: @users
end
