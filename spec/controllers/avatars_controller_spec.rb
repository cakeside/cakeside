require "spec_helper"

describe AvatarsController do
  let(:user) { FactoryGirl.create(:user) }

  before { http_login(user) }

  describe :create do
    context "when uploading a new avatar" do
      let(:image) { Rack::Test::UploadedFile.new('spec/support/gorilla.jpg', 'image/jpeg') }

      before { post :create, :avatar => { :avatar => image } }

      it "should save the new avatar" do
        Avatar.last.should_not be_nil
      end

      it "should redirect to the profile page" do
        response.should redirect_to(profile_path(user))
      end
    end
  end
end
