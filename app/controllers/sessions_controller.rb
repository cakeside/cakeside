class SessionsController < ApplicationController
  def new
    @session = UserSession.new
  end

  def create
    if @session = UserSession.login(session_params[:username], session_params[:password])
      @session.access(request)
      cookies.signed[:cookie_monster] = {
        value: @session.key,
        secure: Rails.env.production? || Rails.env.staging?,
        httponly: true,
        expires: 2.weeks.from_now,
      }
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
