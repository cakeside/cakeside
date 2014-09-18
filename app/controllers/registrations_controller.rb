class RegistrationsController < ApplicationController
  def create
    user = User.create(secure_params)
    if user.save
      cookies.signed[:raphael] = User.login(secure_params[:email], secure_params[:password]).access(request)
      redirect_to my_root_path
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
