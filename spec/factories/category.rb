FactoryGirl.define do
  factory :category, class: Category do
    name { Faker::Name.name }
    slug { Faker::Name.name }
  end
end
