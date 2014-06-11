require 'rails_helper'

describe ProfilesController do
  include Devise::TestHelpers

  let(:user) { create(:user) }
  let!(:creation) { create(:creation, user: user) }

  before (:each) do
    request.env['warden'] = double(Warden, :authenticate => user, :authenticate! => user)
  end

  describe "GET 'index'" do
    before :each do
      get 'index'
    end

    it "should be successful" do
      response.should be_success
    end

    it "should include each user" do
      assigns(:profiles).should include(user)
    end
  end

  describe "GET 'show'" do
    before :each do
      User.stub(:find).with(user.id.to_s){ user }
      get :show, :id => user.id
    end

    it "should be successful" do
      response.should be_success
    end
  end
end
