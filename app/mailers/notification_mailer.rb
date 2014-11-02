class NotificationMailer < ActionMailer::Base
  default from: "noreply@cakeside.com"

  def notification_email(user)
    @user = user
    mail(to: @user.email, subject: "New Activity on CakeSide")
  end
end
