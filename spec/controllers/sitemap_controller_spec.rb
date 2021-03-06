require "rails_helper"

describe SitemapController do
  describe "#index" do
    render_views

    let!(:cake) { create(:cake) }
    let!(:tutorial) { create(:tutorial) }

    it "returns the correct headers and body" do
      get :index, format: :xml

      expect(response).to be_success
      expect(response.body).to_not be_empty
      expect(response.content_type).to eql('application/xml')
      expect(response.body).to include(cake_url(cake))
      expect(response.body).to include(tutorial_url(tutorial))
    end
  end
end
