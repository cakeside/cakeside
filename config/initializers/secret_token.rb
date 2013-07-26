# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Cake::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || 'b975c91e8211689a2ba7a3df9237f33a70219f9c7e4da3a83c8ebe9165cf98f5645943eb97717c963e366660f19cfcb3018a784835291a1d83a8ffee305678b2'
