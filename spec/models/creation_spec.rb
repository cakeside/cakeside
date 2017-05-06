require 'rails_helper'

describe Creation do
  subject { Creation.new }

  describe "should be able to set attributes" do
    it "should save name" do
      subject.name="HELLO WORLD"
      subject.category = create(:category)
      subject.save!
      expect(Creation.find(subject.id).name).to eql("HELLO WORLD")
    end
  end

  describe "#liked_by" do
    let(:user) { create(:user) }
    let(:creation) { create(:creation) }

    context "when the user already likes the creation" do
      let!(:favorite) { creation.favorites.create(:user => user) }
      let(:result) { creation.liked_by(user) }

      it "returns the existing favorite" do
        expect(result).to eql(favorite)
      end
    end

    context "when the user does not like the creation yet" do
      let(:result) { creation.liked_by(user) }

      it "creates a new favorite" do
        expect(result).to_not be_nil
        expect(result.user).to eql(user)
        expect(result.creation).to eql(creation)
        expect(creation.reload.favorites.count).to eql(1)
      end
    end
  end
end
