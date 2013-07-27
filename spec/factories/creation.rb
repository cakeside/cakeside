FactoryGirl.define do
  factory :creation, class: Creation do
    name { Faker::Name.name }
    story 'whats the story morning glory?'
    #image { File.new(File.join( Rails.root, 'spec/fixtures/images/example.png')) }
  end
end
