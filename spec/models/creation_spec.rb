require 'rails_helper'

describe Creation do
  subject { build(:creation) }

  describe "#liked_by" do
    let(:user) { create(:user) }
    let(:creation) { create(:creation) }

    context "when the user already likes the creation" do
      let!(:favorite) { creation.favorites.create(user: user) }
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
