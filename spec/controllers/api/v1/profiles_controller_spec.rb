require "rails_helper"

module Api
  module V1
    describe ProfilesController do
      render_views
      let(:user) { create(:user) }

      before :each do
        api_login(user)
      end

      describe "#show" do
        it "loads the current users profile" do
          xhr :get, :show, id: "me"
          expect(assigns(:profile)).to eql(user)
        end
      end

      describe "#update" do
        it "updates the users profile" do
          new_attributes = {
            name: "new name",
            email: "new@example.com",
            city: "new town",
            website: "http://example.com",
            twitter: "blabber",
            facebook: "facebookie",
          }

          xhr :patch, :update, id: "me", profile: new_attributes

          user.reload
          expect(user.name).to eql("new name")
          expect(user.email).to eql("new@example.com")
          expect(user.city).to eql("new town")
          expect(user.website).to eql("http://example.com")
          expect(user.twitter).to eql("blabber")
          expect(user.facebook).to eql("facebookie")
        end

        it "returns errors" do
          xhr :patch, :update, id: "me", profile: { email: "" }
          json = JSON.parse(response.body)
          expect(json["email"]).to_not be_empty
        end
      end
    end
  end
end
