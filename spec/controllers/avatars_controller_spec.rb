require "spec_helper"

describe AvatarsController do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    http_login(user)
  end

  describe :create do
    context "when uploading a new avatar" do
      let(:image) { Rack::Test::UploadedFile.new('spec/support/gorilla.jpg', 'image/jpeg') }

      before { post :create, :avatar => { :avatar => image } }

      it "should save the new avatar" do
        Avatar.last.should_not be_nil
      end
    end
  end
end
