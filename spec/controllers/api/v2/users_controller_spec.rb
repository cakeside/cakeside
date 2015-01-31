require "rails_helper"

module Api
  module V2
    describe UsersController do
      render_views

      describe "#index" do
        let!(:user) { create(:user) }

        it "loads all users" do
          xhr :get, :index
          expect(assigns(:users)).to match_array([user])
        end
      end

      describe "#show" do
        let!(:user) { create(:user) }

        it "loads the info on the user" do
          xhr :get, :show, id: user.id
          expect(assigns(:user)).to eql(user)
        end
      end
    end
  end
end
