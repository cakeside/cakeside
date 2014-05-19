module Admin
  class UsersController < AdminController
    def index
      @users = User.includes(:avatar).order(sign_in_count: :desc)
      expires_in(10.minutes)
    end

    def show
      @user = User.find(params[:id])
    end
  end
end
