FactoryGirl.define do
  factory :photo, class: Photo do
    image { File.new(File.join( Rails.root, 'spec/fixtures/images/example.png')) }
  end
end
