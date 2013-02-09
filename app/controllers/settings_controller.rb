class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def change_password
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:alert] = "Passwords must match." 
      redirect_to :back
      return
    end
    @user = User.find(current_user.id)
    @user.password=params[:user][:password]
    if @user.save
      sign_in @user, :bypass => true
      redirect_to profile_path(current_user), notice: 'Your password has been changed!'
    else
      flash[:alert] = "Invalid password, must be at least 6 charactors."
      redirect_to :back
    end
  end
end
