class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
  end

  def update
    @user = current_user
    @user.interest_ids = params[:user][:interest_ids] ||= []
    if @user.update_without_password(user_params)
      redirect_to settings_path, :notice => 'Your settings have been updated successfully!'
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :city, :website, :twitter, :facebook)
  end
end
