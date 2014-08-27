module Admin
  class SessionsController < AdminController
    def index
      @user_sessions = UserSession.active
    end

    def destroy
      UserSession.find(params[:id]).revoke!
      redirect_to admin_sessions_path
    end
  end
end
