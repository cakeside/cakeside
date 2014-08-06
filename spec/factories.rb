FactoryGirl.define do
  factory :activity, class: Activity do
    user { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:creation) }
  end
  factory :category, class: Category do
    name { Faker::Name.name }
    slug { Faker::Name.name.gsub(/ /, "-").downcase }
  end
  factory :creation, class: Creation do
    name { Faker::Name.name }
    story 'whats the story morning glory?'
    user { FactoryGirl.create(:user) }
    association :category
  end

  factory :cake, class: Creation do
    name { Faker::Name.name }
    story 'whats the story morning glory?'
    association :user
    association :category
  end

  factory :favorite do
    user { FactoryGirl.create(:user) }
    creation { FactoryGirl.create(:creation) }
  end
  factory :photo, class: Photo do
    image { 'example.png' }
  end
  factory :tag, :class => "ActsAsTaggableOn::Tag" do
    name { Faker::Name.name }
  end
  factory :tutorial do
    heading { Faker::Name.name }
    description "well hello there"
    url { Faker::Internet.http_url }
    image_url { Faker::Internet.http_url }
    author { Faker::Name.name }
    author_url { Faker::Internet.http_url }
  end
  factory :user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
    website { Faker::Internet.http_url }
    city 'calgary'
  end
end
