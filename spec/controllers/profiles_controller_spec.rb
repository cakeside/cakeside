require 'spec_helper'

describe ProfilesController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.build(:user) }

  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
  end

  describe "GET 'index'" do
    it "should be successful" do
      User.stub(:all){ [user] }
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      User.stub(:find).with(user.id.to_s){ user }
      get :show, :id => user.id
      response.should be_success
    end
  end

end
