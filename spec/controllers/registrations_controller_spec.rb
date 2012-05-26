require 'spec_helper'
#module Devise
  #class RegistrationsController

  #end
#end

describe RegistrationsController do
  before (:each) do
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
  end
  let(:user){ FactoryGirl.build(:user) }

  context "when updating a users profile settings not including their password" do
    it "should update their website" do
      controller = RegistrationsController.new

      blah = {
        :current_password =>'',
        :email => '',
        :facebook => '',
        #:name =>'',
        :password => '',
        :password_confirmation => '',
        :twitter => '',
        :website => '',
      }

      #user.should_receive[:update_without_password].with(blah)
      #controller.update
      put :update, :user => {:hello => "mo"}
    end
    it "should not change their password" do
      
    end
  end
  context "when updating a users pasword" do
    it "should update their password" do
      
    end
  end
end
