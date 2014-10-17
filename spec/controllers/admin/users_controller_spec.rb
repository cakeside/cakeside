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

      it "returns users that match the search results" do
        matching_user = double
        repository = double
        controller.stub(:repository).and_return(repository)
        repository.stub(:search_by).with('mo').and_return([matching_user])
        get :index, q: 'mo'
        expect(assigns(:users)).to include(matching_user)
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
