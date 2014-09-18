class PasswordsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    PasswordReset.send_reset_instructions_to(params[:user][:email])
    redirect_to new_session_path, notice: 'Password reset instructions have been emailed to you.'
  end
end
