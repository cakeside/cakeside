class SessionsController < ApplicationController
  def new
    redirect_to my_dashboard_path if user_signed_in?
    @session = UserSession.new
  end

  def create
    if @session = User.login(session_params[:username], session_params[:password])
      cookies.signed[:raphael] = @session.access(request)
      redirect_to my_dashboard_path
    else
      flash[:error] = "Ooops... invalid email or password."
      redirect_to login_path
    end
  end

  def destroy
    user_session.revoke!
    cookies.delete(:raphael)
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
