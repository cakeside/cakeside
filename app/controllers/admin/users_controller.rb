module Admin
  class UsersController < AdminController
    def index
      @users = User.search_by(params[:q])
    end

    def show
      @user = User.includes(creations: :photos).find(params[:id])
    end
  end
end
