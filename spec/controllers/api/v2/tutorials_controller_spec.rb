require 'rails_helper'

module Api
  module V2
    describe TutorialsController do
      render_views
      describe "#index" do
        let!(:tutorial) { create(:tutorial) }

        before :each do
          xhr :get, :index
        end

        it 'loads all the tutorials' do
          expect(assigns(:tutorials)).to match_array([tutorial])
        end

        it 'responds with json' do
          json = JSON.parse(response.body)
          expect(json['tutorials'].count).to eql(1)
          expect(json['tutorials'][0]['heading']).to eql(tutorial.heading)
          expect(json['tutorials'][0]['description']).to eql(tutorial.description)
          expect(json['tutorials'][0]['url']).to eql(tutorial.url)
          expect(json['tutorials'][0]['submitter']).to eql(tutorial.user.id)
          expect(json['tutorials'][0]['image_url']).to eql(tutorial.image_url)
        end
      end
    end
  end
end
