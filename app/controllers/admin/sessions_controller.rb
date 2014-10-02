module Admin
  class SessionsController < AdminController
    def index
      @user_sessions = UserSession.includes(:user, :location).order(created_at: :desc).all
    end

    def destroy
      UserSession.find(params[:id]).revoke!
      redirect_to admin_sessions_path
    end
  end
end
