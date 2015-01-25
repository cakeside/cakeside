require "rails_helper"

describe Api::V1::CakesController do
  render_views

  context "when signed in" do
    let(:user) { create(:user) }

    before :each do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.authentication_token)
    end

    describe "#index" do
      let!(:my_cake) { create(:creation) }
      let!(:other_cake) { create(:creation) }

      before :each do
        user.creations << my_cake
        xhr :get, :index
      end

      it "returns all of my cakes" do
        expect(assigns(:cakes)).to match_array([my_cake])
      end

      it "does not return any other cakes" do
        expect(assigns(:cakes)).to_not include(other_cake)
      end
    end

    describe "#show" do
      let!(:cake) { create(:creation) }

      before :each do
        user.creations << cake
        xhr :get, :show, id: cake.id
      end

      it 'loads a specific cake' do
        expect(assigns(:cake)).to eql(cake)
      end
    end

    xdescribe "#create" do

    end

    xdescribe "#update" do

    end

    describe "#destroy" do
      let!(:cake) { create(:creation) }

      before :each do
        user.creations << cake
        xhr :delete, :destroy, id: cake.id
      end

      it 'deletes the specified cake' do
        expect(Creation.exists?(cake.id)).to be_falsey
      end
    end
  end
end
