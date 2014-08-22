require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cake
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/app/services/application)
    config.autoload_paths += %W(#{config.root}/app/services/application/handlers)
    config.autoload_paths += %W(#{config.root}/app/services/domain)
    config.autoload_paths += %W(#{config.root}/app/services/infrastructure)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.to_prepare {
      Devise::SessionsController.layout "application"
      # Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "users" }
      Devise::ConfirmationsController.layout "application"
      Devise::UnlocksController.layout "application"
      Devise::PasswordsController.layout "application"
    }
    config.middleware.use ExceptionNotification::Rack, :email => {
      :email_prefix => "[Boom! #{Rails.env}] ",
      :sender_address => %{"notifier" <notifier@cakeside.com>},
      :exception_recipients => ENV['EXCEPTION_EMAIL_ADDRESS'].split(" ")
    } unless Rails.env.test?
  end
end
