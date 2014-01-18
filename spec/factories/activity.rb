FactoryGirl.define do
  factory :activity, class: Activity do
    user { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:creation) }
  end
end
