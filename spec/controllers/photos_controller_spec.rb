describe PhotosController do
  let(:user){ FactoryGirl.create(:user) }
  let(:creation){ FactoryGirl.create(:creation) }

  before (:each) do
    user.creations << creation
    http_login(user)
  end

  describe "POST create" do
    before :each do
      post :create, :creation_id => creation.id
    end
    it "returns http success" do
      response.should be_success
    end
    it "should upload a new photo" do
      assigns(:photo).should_not be_nil
    end
  end

  describe "DELETE 'destroy'" do
    let(:photo) { fake }
    before :each do
      creation.stub(:photos).and_return(photo)
      delete :destroy, :creation_id => creation.id, :id => 88
    end
    pending "returns http success" do
      response.should be_success
    end
    pending "should destroy the photo" do
      photo.should have_received(:destroy)
    end
    pending "should redirect to the creation" do
      
    end
  end
end
