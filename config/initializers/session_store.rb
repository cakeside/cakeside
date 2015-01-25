# Be sure to restart your server when you modify this file.
configuration = {
  key: "_cake_eater_#{Rails.env}",
  expire_after: 1.day,
  secure: Rails.env.production? || Rails.env.staging?,
}
Cake::Application.config.session_store ActionDispatch::Session::CacheStore, configuration
