module Api
  module V1
    class LoginsController < ApplicationController
      def create
        @user = User.find_by_email(params[:email])
        if @user.authenticate(params[:password])
          render json: { auth_token: @user.authentication_token }
        else
          render json: { auth_token: "" }
        end
      end
    end
  end
end
