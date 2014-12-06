FactoryGirl.define do
  factory :activity, class: Activity do
    user { create(:user) }
    subject { create(:favorite) }
  end

  factory :category, class: Category do
    name { Faker::Name.name }
    slug { Faker::Name.name.gsub(/ /, "-").downcase }
  end

  factory :cake, class: Creation, aliases: [:creation] do
    name { Faker::Name.name }
    story { Faker::HipsterIpsum.words(50).join(' ') }
    association :user
    association :category
    factory :published_cake do
      after(:create) do |cake, evaluator|
        cake.photos << create(:photo, image: 'spec/fixtures/images/example.png')
      end
    end
  end

  factory :user_session, class: UserSession do
    association :user
    key SecureRandom.urlsafe_base64(32)
    ip Faker::Internet.ip_v4_address
    factory :active_session do
      accessed_at Time.now
    end
  end

  factory :favorite do
    association :user
    association :creation
  end

  factory :photo, class: Photo do
    image { 'spec/fixtures/images/example.png' }
    content_type { "" }
    original_filename { "" }
    latitude { "" }
    longitude { "" }
    sha256 { "" }
    watermark { "" }
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
    association :user
  end

  factory :user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
    website { Faker::Internet.http_url }
    city 'calgary'
    factory :admin do
      admin true
    end
  end

  factory :location do
    latitude "107"
    longitude "99"
    city "Calgary"
    country "Canada"
  end

  factory :tool do
    name { Faker::Name.name }
    asin { SecureRandom.uuid }
  end
end