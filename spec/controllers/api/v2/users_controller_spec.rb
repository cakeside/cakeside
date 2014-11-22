require 'rails_helper'

module Api
  module V2
    describe UsersController do
      describe "#show" do
        let!(:user) { create(:user) }

        it 'loads the info on the user' do
          xhr :get, :show, id: user.id
          expect(assigns(:user)).to eql(user)
        end
      end
    end
  end
end
