class PasswordsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    PasswordReset.send_reset_instructions_to(params[:user][:email])
    redirect_to new_session_path, notice: 'Password reset instructions have been emailed to you.'
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])
    redirect_to root_path if @user.nil?
  end

  def update
    PasswordReset.reset(params[:id], params[:user][:password])
    redirect_to new_session_path
  end
end
