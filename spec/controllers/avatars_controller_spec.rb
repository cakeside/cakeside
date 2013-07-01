require "spec_helper"

describe AvatarsController do
  let(:user) { FactoryGirl.create(:user) }

  context "when logged in " do
    before { http_login(user) }

    describe :update do
      context "when uploading a new avatar" do
        let(:image) { Rack::Test::UploadedFile.new('spec/fixtures/images/gorilla.jpg', 'image/jpeg') }

        before { put :update, :id => user.id, :avatar => { :avatar => image } }

        it "should save the new avatar" do
          Avatar.last.should_not be_nil
          Avatar.last.avatar.should_not be_blank
        end

        it "should redirect to the profile page" do
          response.should redirect_to avatar_path(user)
        end

        it "should display a flash notice" do
          flash[:notice].should_not be_nil
        end
      end
    end

    describe :edit do
      before :each do
        get :edit, :id => user.id
      end

      it "should display the current avatar" do
        assigns(:avatar).should_not be_nil
      end
    end
  end
end
