class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def update
    user = User.find(params[:id])
    if user.change_password(params[:user][:password], params[:user][:password_confirmation])
      render :show
    else
      flash[:alert] = t(:passwords_do_not_match)
      render :show
    end
  end
end
