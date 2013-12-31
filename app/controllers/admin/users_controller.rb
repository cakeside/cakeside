module Admin
  class UsersController < AdminController
    def index
      @users = User.includes(:avatar).order(:created_at => :desc)
      @recent_users = @users.limit(10)
      @active_users = @users.order(:updated_at).limit(10)
      expires_in(10.minutes)
      fresh_when(User.maximum(:updated_at)) if User.any?
    end
  end
end
