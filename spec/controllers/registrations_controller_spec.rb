require 'spec_helper'

describe RegistrationsController do
  let(:sut) { RegistrationsController.new }
  let(:user){ fake }

  context "when updating a users profile settings not including their password" do
    it "should update their website" do
      sut.stub(:current_user).and_return(user)

      payload = {
        :current_password => '',
        :email => 'mo@mokhan.ca',
        :facebook => 'mo',
        :name =>'mo',
        :password => '',
        :password_confirmation => '',
        :twitter => 'mocheen',
        :website => 'http://mokhan.ca/',
      }

      user.should have_received(:update_without_password,payload)
    end

    it "should not change their password" do

    end
  end
  context "when updating a users pasword" do
    it "should update their password" do

    end
  end
end

#HTTP GET /creations/ => creations#index
#HTTP GET /creations/1 => creations#show
#HTTP GET /creations/1/edit => creations#edit
#HTTP PUT /creations/1 => creations#update
#HTTP POST /creations/ => creations#create
#HTTP DELETE /creations/1 => creations#destroy



