class UserMailer < ActionMailer::Base
  default from: "noreply@cakeside.com"

  def welcome_email(user)
    @url = 'https://www.cakeside.com/login'
    @user = user
   mail(to: @user.email, subject: "Welcome to CakeSide")
  end
end
