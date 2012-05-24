#require_relative '../../app/controllers/registrations_controller'
require 'spec_helper'

describe RegistrationsController do
  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
  end
  let(:user){ FactoryGirl.build(:user) }

  context "when updating a users website" do
    it "should update their website" do
      controller = RegistrationsController.new
      #controller.update

      blah = {
        :current_password =>'',
        :email => '',
        :facebook => '',
        :name =>'',
        :password => '',
        :password_confirmation => '',
        :twitter => '',
        :website => '',
      }

      user.should_receive[:update_without_password].with(blah)
      put :update, :user => blah
    end
    it "should not change their password" do
      
    end
  end
  context "when updating a users pasword" do
    it "should update their password" do
      
    end
  end
end
