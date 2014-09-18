require 'rails_helper'

describe RegistrationsController do
  describe "#create" do
    it 'creates a new user' do
      post :create, user: { name: 'mo', email: 'mo@cakeside.com', password: 'password', password_confirmation: 'password' }

      expect(User.count).to eql(1)
      expect(response).to redirect_to(my_root_path)
    end

    it 'displays errors' do
      post :create, user: { name: 'mo', email: 'mo', password: 'password', password_confirmation: 'password' }
      expect(response).to redirect_to(new_session_path)
      expect(flash[:error]).to_not be_empty
    end
  end
end
