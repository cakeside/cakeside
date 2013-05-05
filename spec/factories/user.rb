FactoryGirl.define do
  factory :user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
    website { Faker::Internet.http_url }
    city 'calgary'
  end
end
