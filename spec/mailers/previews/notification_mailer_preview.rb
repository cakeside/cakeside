class NotificationMailerPreview < ActionMailer::Preview
  def notification_email
    NotificationMailer.notification_email(Activity.last)
  end
end
