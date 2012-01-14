# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Cake::Application
Cake::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[Cake] ",
  :sender_address => %{"notifier" <noreply@cakeside.com>},
  :exception_recipients => %w{cakeside+bugs@mokhan.ca}
