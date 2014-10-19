require 'rails_helper'

describe User::Repository do
  subject { User::Repository.new }

  describe "#all" do
    let!(:user) { create(:user) }

    it 'returns all the users' do
      expect(subject.all).to include(user)
    end
  end

  describe "#ordered" do
    let!(:first_person) { create(:user, creations_count: 0) }
    let!(:second_person) { create(:user, creations_count: 1) }

    let(:results) { subject.ordered }

    it "should load the person with the most cakes first" do
      expect(results.first).to eql(second_person)
    end

    it "should load the person with the least cakes last" do
      expect(results.last).to eql(first_person)
    end
  end

  describe "#search_by" do
    let!(:mo) { create(:user) }
    let!(:bob) { create(:user) }

    it "returns a user that has a matching email address" do
      results = subject.search_by(mo.email)
      expect(results).to include(mo)
      expect(results).to_not include(bob)
    end

    it "returns a user that has a matching name" do
      results = subject.search_by(bob.name)
      expect(results).to include(bob)
      expect(results).to_not include(mo)
    end
  end

  describe "#search_with" do
    let!(:mo) { create(:user, creations_count: 1) }
    let!(:bob) { create(:user, creations_count: 1) }

    it 'returns all artists with the matching name' do
      results = subject.search_with(q: bob.name)
      expect(results).to include(bob)
      expect(results).to_not include(mo)
    end
  end
end
