require "rails_helper"

module Admin
  describe UsersController do
    let(:admin) { build(:admin) }

    before :each do
      http_login(admin)
    end

    describe "#index" do
      let!(:user) { create(:user) }

      it "returns all users" do
        get :index
        expect(assigns(:users)).to include(user)
      end
    end

    describe "#show" do
      let!(:user) { create(:user) }

      it "loads the details on the specific user" do
        get :show, id: user.id
        expect(assigns(:user)).to eql(user)
      end
    end
  end
end
