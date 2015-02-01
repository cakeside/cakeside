class RegistrationsController < ApplicationController
  def create
    user = User.create(secure_params)
    if user.save
      email, password = secure_params[:email], secure_params[:password]
      session[:raphael] = User.login(email, password).access(request)
      redirect_to my_dashboard_path
    else
      flash[:error] = user.errors.full_messages
      redirect_to new_session_path
    end
  end

  private

  def secure_params
    params.require(:user).permit(:name, :email, :password)
  end
end
