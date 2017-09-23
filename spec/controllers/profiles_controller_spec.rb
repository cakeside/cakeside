require 'rails_helper'

describe ProfilesController do
  describe "#index" do
    let!(:user) { create(:user, creations_count: 1) }

    it "includes each user" do
      get :index
      expect(assigns(:profiles)).to match_array(user)
      expect(response).to be_success
    end
  end

  describe "#show" do
    let(:user) { create(:user) }
    let(:creation) { create(:creation, user: user) }

    before :each do
      get :show, params: { id: user.id }
    end

    it "returns a successful response" do
      expect(response).to be_success
    end

    it 'returns the user' do
      expect(assigns(:user)).to eql(user)
    end

    it 'returns the users cakes' do
      expect(assigns(:creations)).to match_array(user.creations)
    end
  end
end
