FactoryGirl.define do
  factory :user, class: User do
    id 1002
    name 'mo'
    email 'mo@cakeside.com'
    password 'password'
    website 'http://cakeside.com'
  end
end
