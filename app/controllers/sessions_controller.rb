class SessionsController < ApplicationController
  def new
    @session = UserSession.new
  end

  def create
    if @session = User.login(session_params[:username], session_params[:password])
      cookies.signed[:cookie_monster] = @session.access(request)
      redirect_to my_dashboard_path
    else
      flash[:error] = "invalid credentials"
      redirect_to new_session_path
    end
  end

  def destroy
    cookies.delete(:cookie_monster)
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
