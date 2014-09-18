class PasswordResetMailer < ActionMailer::Base
  default from: "noreply@cakeside.com"

  def send_password_reset_instructions_to(user)
    @user = user
    mail(to: @user.email, subject: "CakeSide - Password Reset Request")
  end
end
