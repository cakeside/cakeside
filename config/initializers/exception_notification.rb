Rails.application.config.middleware.use ExceptionNotification::Rack, email: {
  email_prefix: "[Boom! #{Rails.env}] ",
  sender_address: %{"notifier" <notifier@cakeside.com>},
  exception_recipients: ENV["EXCEPTION_EMAIL_ADDRESS"].try(:split, " "),
} unless Rails.env.test?
