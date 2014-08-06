class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    user_session = Session.login(session_params[:username], session_params[:password])
    cookies.signed[:cookie_monster] = user_session.id
    render nothing: true
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
