require "rails_helper"

describe My::SettingsController do
  describe "#index" do
    it "should load the current user" do
      user = create(:user)
      http_login(user)
      get :index
      expect(assigns(:user)).to eql(user)
    end
  end

  describe "#update" do
    let(:user) { create(:user) }

    before :each do
      http_login(user)
      patch :update, params: {
        id: user.id,
        user: {
          name: 'mo khan',
          email: 'mo@mokhan.ca',
          city: 'Calgary',
          website: 'http://mokhan.ca/',
          twitter: 'mocheen',
          facebook: 'fb'
        }
      }
    end

    it "updates the users settings" do
      user.reload
      expect(user.name).to eql('mo khan')
      expect(user.email).to eql('mo@mokhan.ca')
      expect(user.city).to eql('Calgary')
      expect(user.website).to eql('http://mokhan.ca/')
      expect(user.twitter).to eql('mocheen')
      expect(user.facebook).to eql('fb')
    end

    it "redirects to the settings page" do
      expect(response).to redirect_to(my_settings_path)
    end

    it "includes a success message" do
      expect(flash[:notice]).to eql(I18n.t(:profile_saved))
    end
  end
end
