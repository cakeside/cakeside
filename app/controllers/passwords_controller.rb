class PasswordsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    PasswordReset.send_reset_instructions_to(params[:user][:email])
    redirect_to new_session_path, notice: t("passwords.send_instructions")
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])
    redirect_to root_path if @user.nil?
  end

  def update
    user = PasswordReset.reset(params[:id], params[:user][:password])
    if user.valid?
      redirect_to new_session_path
    else
      flash[:error] = user.errors.full_messages
      redirect_to edit_password_path(params[:id])
    end
  end
end
