require 'spec_helper'

describe PhotosController do
  include Devise::TestHelpers

  let(:user){ FactoryGirl.create(:user) }
  let(:creation){ FactoryGirl.create(:creation) }

  def mock_creation(stubs={})
    @mock_creation ||= mock_model(Creation, stubs).as_null_object
  end

  def mock_photo(stubs={})
    @mock_photo ||= mock_model(Photo, stubs).as_null_object
  end

  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
  end

  describe "GET 'create'" do
    it "returns http success" do
      user.stub(:creations) { mock_creation }
      mock_photo.stub(:id) {"1"}
      mock_photo.stub(:save) {true}
      mock_creation.stub(:photos) { mock_photo }
      get :create, :id => "1", :creation_id => "14"
      # response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      # get 'destroy'
      # response.should be_success
    end
  end

end
