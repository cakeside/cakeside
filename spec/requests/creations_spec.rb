require 'spec_helper'

describe "Creations" do
  describe "GET /creations" do
    before(:each) do
      FactoryGirl.create(:creation, :is_published => true)
    end
    it "works! (now write some real specs)" do
      get creations_path
      response.status.should be(200)
    end
  end
end
