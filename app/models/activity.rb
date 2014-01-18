class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :user
  after_create :send_notification_email

  def send_notification_email
    NotificationMailer.delay.notification_email(self)
  end
end
