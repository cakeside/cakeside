FactoryGirl.define do
  factory :user, class: User do
    id 1002
    name 'mo'
    email 'mo@cakeside.com'
    password 'password'
    website 'cakeside.com'
  end
end
