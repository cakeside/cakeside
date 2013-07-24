require 'spec_helper'

describe RegistrationsController do
  let(:sut) { RegistrationsController.new }
  let(:user){ fake }

  describe "when updating a users settings not including their password" do
    before(:each) do
      @payload = {
        :user => {
          :current_password => '',
          :email => 'mo@mokhan.ca',
          :facebook => 'mo',
          :name =>'mo',
          :password => '',
          :password_confirmation => '',
          :twitter => 'mocheen',
          :website => 'http://mokhan.ca/',
          :interest_ids => []
        }
      }
      sut.stub(:current_user).and_return(user)
      sut.stub(:params).and_return(@payload)
      sut.stub(:update_without_password).and_return(true)
      sut.stub(:render).and_return(true)

      sut.update
    end

    xit "should update their website" do
      user.should have_received(:update_without_password,@payload[:user])
    end
  end
end
