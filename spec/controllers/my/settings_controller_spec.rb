require "rails_helper"

describe My::SettingsController do
  describe "#index" do
    it "should load the current user" do
      user = create(:user)
      http_login(user)
      get :index
      assigns(:user).should == user
    end
  end

  describe "#update" do
    let(:user) { create(:user) }

    before :each do
      http_login(user)
      patch :update, id: user.id, user: { name: 'mo khan', email: 'mo@mokhan.ca', city: 'Calgary', website: 'http://mokhan.ca/', twitter: 'mocheen', facebook: 'fb' }
      user.reload
    end

    it "should update the users settings" do
      user.name.should == 'mo khan'
      user.email.should == 'mo@mokhan.ca'
      user.city.should == 'Calgary'
      user.website.should == 'http://mokhan.ca/'
      user.twitter.should == 'mocheen'
      user.facebook.should == 'fb'
    end

    it "should redirect to the settings page" do
      response.should redirect_to(my_settings_path)
    end

    it "should include a success message" do
      flash[:notice].should == I18n.t(:profile_saved)
    end
  end
end
