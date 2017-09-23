require "rails_helper"

module Api
  module V2
    describe TutorialsController do
      render_views

      describe "#index" do
        let!(:tutorial) { create(:tutorial) }

        before :each do
          get :index, xhr: true
        end

        it "loads all the tutorials" do
          expect(assigns(:tutorials)).to match_array([tutorial])
        end

        it "responds with json" do
          json = JSON.parse(response.body)
          expect(json["tutorials"].count).to eql(1)
          json_tutorial = json["tutorials"][0]
          expect(json_tutorial["id"]).to eql(tutorial.id)
          expect(json_tutorial["heading"]).to eql(tutorial.heading)
          expect(json_tutorial["description"]).to eql(tutorial.description)
          expect(json_tutorial["url"]).to eql(tutorial.url)
          expect(json_tutorial["submitter"]).to eql(tutorial.user.id)
          expect(json_tutorial["imageUrl"]).to eql(tutorial.image_url)
        end
      end

      describe "#show" do
        let!(:tutorial) { create(:tutorial) }

        it "loads the single tutorial" do
          get :show, params: { id: tutorial.id }, xhr: true
          expect(assigns(:tutorial)).to eql(tutorial)
        end
      end
    end
  end
end
