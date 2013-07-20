class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
  end

  def update
    user = current_user
    if user.change_password(params[:user][:password], params[:user][:password_confirmation])
      sign_in(user, :bypass => true) unless Rails.env.test?
      flash[:notice] = "Your password has been updated successfully!"
      render :index
    else
      flash[:error] = t(:passwords_do_not_match)
      render :index
    end
  end
end
