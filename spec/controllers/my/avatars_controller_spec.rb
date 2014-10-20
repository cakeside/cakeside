require "rails_helper"

describe My::AvatarsController do
  let(:user) { create(:user) }

  context "when logged in " do
    before { http_login(user) }

    describe "#create" do
      context "when uploading a new avatar" do
        let(:image) { Rack::Test::UploadedFile.new('spec/fixtures/images/gorilla.jpg', 'image/jpeg') }

        before { post :create, photo: { image: image } }

        it "should save the new avatar" do
          user.reload
          expect(user.avatar).to_not be_nil
          expect(user.avatar.image).to_not be_blank
        end

        it "should redirect to the avatar page" do
          expect(response).to redirect_to(new_my_avatar_path)
        end

        it "should display a flash notice" do
          expect(flash[:notice]).to_not be_nil
        end
      end
    end

    describe "#new" do
      before { get :new, id: user.id }

      it "should display the current avatar" do
        expect(assigns(:avatar)).to_not be_nil
      end
    end
  end
end
