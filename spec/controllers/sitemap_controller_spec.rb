require "rails_helper"

describe SitemapController do
  describe "#index" do
    let!(:cake) { create(:cake) }
    let!(:tutorial) { create(:tutorial) }

    it "returns the most recent cakes" do
      get :index, format: :xml
      puts "BODY: #{response.body.inspect}"
      expect(response.body).to_not be_empty
    end
  end
end
