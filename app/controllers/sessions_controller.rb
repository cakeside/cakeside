class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.login(session_params[:username], session_params[:password])
    if @session
      cookies.signed[:cookie_monster] = @session.id
      render nothing: true
    else
      flash[:error] = "invalid credentials"
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
