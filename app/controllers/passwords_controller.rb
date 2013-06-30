class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
  end

  def update
    user = User.find(params[:id])
    if user.change_password(params[:user][:password], params[:user][:password_confirmation])
      render :index
    else
      flash[:alert] = t(:passwords_do_not_match)
      render :index
    end
  end
end
