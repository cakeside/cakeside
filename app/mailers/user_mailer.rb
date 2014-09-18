class UserMailer < ActionMailer::Base
  default from: "noreply@cakeside.com"

  def welcome_email(user)
    @user = user
   mail(to: @user.email, subject: "Welcome to CakeSide")
  end
end
