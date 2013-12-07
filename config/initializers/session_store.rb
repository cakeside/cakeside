# Be sure to restart your server when you modify this file.
configuration = {
  key: '_cake_eater',
  expire_after: 1.day
}
Cake::Application.config.session_store ActionDispatch::Session::CacheStore, configuration
