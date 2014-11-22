module Api
  module V2
    class UsersController < ApplicationController
      def index
        @users = User.page(page).per(per_page)
      end

      def show(id = params[:id])
        @user = User.find(id)
      end
    end
  end
end
