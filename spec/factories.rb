FactoryGirl.define do
  factory :activity, class: Activity do
    user { create(:user) }
    subject { create(:favorite) }
  end

  factory :category, class: Category do
    name { FFaker::Name.name }
    slug { FFaker::Name.name.parameterize }
  end

  factory :cake, class: Creation, aliases: [:creation] do
    name { FFaker::Name.name }
    story { FFaker::HipsterIpsum.words(50).join(' ') }
    association :user
    association :category
    factory :published_cake do
      photos_count 1
      after(:create) do |cake, evaluator|
        cake.photos << create(:photo, image: 'spec/fixtures/images/example.png')
      end
    end
  end

  factory :user_session, class: UserSession do
    association :user
    key SecureRandom.urlsafe_base64(32)
    ip FFaker::Internet.ip_v4_address
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
    name { FFaker::Name.name }
  end

  factory :tutorial do
    heading { FFaker::Name.name }
    description "well hello there"
    url { FFaker::Internet.http_url }
    image_url { FFaker::Internet.http_url }
    author { FFaker::Name.name }
    author_url { FFaker::Internet.http_url }
    association :user
  end

  factory :user, class: User do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password 'password'
    website { FFaker::Internet.http_url }
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
    name { FFaker::Name.name }
    asin { SecureRandom.uuid }
  end
end
