class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    if @session = Session.login(session_params[:username], session_params[:password])
      cookies.signed[:cookie_monster] = @session.id
      redirect_to my_dashboard_path
    else
      flash[:error] = "invalid credentials"
      render :new
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
