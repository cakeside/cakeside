require 'rails_helper'

describe RegistrationsController do
  describe "#create" do
    let(:user_session) { double(access: SecureRandom.hex(12)) }

    it 'creates a new user' do
      User.stub(:login).with('mo@cakeside.com', 'password').and_return(user_session)

      post :create, user: { name: 'mo', email: 'mo@cakeside.com', password: 'password' }

      expect(User.count).to eql(1)
      expect(response).to redirect_to(my_dashboard_path)
      expect(cookies.signed[:raphael]).to_not be_nil
      expect(cookies.signed[:raphael]).to eql(user_session.access)
    end

    it 'displays errors' do
      post :create, user: { name: 'mo', email: 'mo', password: 'password', password_confirmation: 'password' }
      expect(response).to redirect_to(new_session_path)
      expect(flash[:error]).to_not be_empty
    end
  end
end
