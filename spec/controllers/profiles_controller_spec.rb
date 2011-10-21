require 'spec_helper'

describe ProfilesController do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user, :authenticate! => mock_user)
  end

  describe "GET 'index'" do
    it "should be successful" do
      User.stub(:all){ mock_user }
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      User.stub(:find).with(mock_user.id.to_s){ mock_user }
      get :show, :id => mock_user.id
      response.should be_success
    end
  end

end
