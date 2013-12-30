module Admin
  class UsersController < AdminController
    def index
      @users = User.includes(:avatar)
    end
  end
end
