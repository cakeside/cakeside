class NotificationMailerPreview < ActionMailer::Preview
  def notification_email
    NotificationMailer.notification_email(User.last)
  end
end
