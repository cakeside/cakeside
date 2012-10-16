require 'spec_helper'

describe "Creations" do
  describe "GET /creations" do
    before(:each) do
      creation = FactoryGirl.create(:creation) do |c|
        c.photos.create(:image => File.new(File.join( Rails.root, 'spec/fixtures/images/example.png')), :is_primary => true)
        c.user = FactoryGirl.create(:user)
      end
      creation.save!
      get creations_path
    end
    it "works! (now write some real specs)" do
      response.status.should be(200)
    end
  end
end
