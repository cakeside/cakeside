FactoryGirl.define do
  factory :favorite do
    user { FactoryGirl.create(:user) }
    creation { FactoryGirl.create(:creation) }
  end
end
