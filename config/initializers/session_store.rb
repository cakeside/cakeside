# Be sure to restart your server when you modify this file.
configuration = {
  key: "_cake_eater_#{Rails.env}",
  expire_after: 2.weeks,
  secure: Rails.env.production? || Rails.env.staging?,
}
Rails.application.config.session_store :cookie_store, configuration
