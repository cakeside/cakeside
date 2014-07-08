require 'rails_helper'

describe CreationsController do
  let(:user){ create(:user) }
  let(:creation){ create(:creation, :user => user) }

  before(:each) do
    photo = 'spec/fixtures/images/example.png'
    creation.photos.create(image: photo, image_processing: nil)
  end

  describe "#index" do
    before { get :index }

    it "should display all creations" do
      assigns(:creations).should include(creation)
    end
  end

  describe "#show" do
    it "assigns the requested creation" do
      get :show, :id => creation.id
      assigns(:creation).should == creation
    end
  end
end
