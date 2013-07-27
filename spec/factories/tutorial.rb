FactoryGirl.define do
  factory :tutorial do
    heading { Faker::Name.name }
    description "well hello there"
    url { Faker::Internet.http_url }
    image_url { Faker::Internet.http_url }
    author { Faker::Name.name }
    author_url { Faker::Internet.http_url }
  end
end
