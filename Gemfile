source 'http://rubygems.org'

gem 'rails'
gem 'rake'
gem 'devise'
gem 'jquery-rails'
gem 'carrierwave'
gem 'RedCloth'
gem 'rmagick'
gem 'bcrypt-ruby'
gem 'json'
gem 'thinking-sphinx'
gem 'fog'
gem 'kaminari'
gem 'capistrano'

group :development, :test do
  gem 'webrat'
  gem 'rspec-rails'
  gem 'jasmine'
  gem 'sqlite3-ruby', :require => 'sqlite3', :group => [:development,:test]
end
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl_notify', :require => false if RUBY_PLATFORM =~ /darwin/i
  # gem 'rb-inotify', :require => false if RUBY_PLATFORM =~ /linux/i
  # gem 'libnotify', :require => false if RUBY_PLATFORM =~ /linux/i
  # Pretty printed test output
  gem 'turn', :require => false
end
group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end
