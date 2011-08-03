source 'http://rubygems.org'

gem 'rails'
gem 'rake'
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'devise'
gem 'heroku'
gem 'jquery-rails'
gem 'carrierwave'
gem 'RedCloth', '>= 4.1.1'
gem 'omniauth'
gem 'rmagick'
gem 'bcrypt-ruby'
gem 'json'
gem 'thinking-sphinx'
gem 'fog'
gem 'kaminari'
gem 'acts-as-taggable-on'
gem 'capistrano'

group :development, :test do
  gem 'webrat'
  gem 'rspec-rails'
  gem 'jasmine'
end
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl', :require => false if RUBY_PLATFORM =~ /darwin/i
  # linux part is not tested
  gem 'rb-inotify', :require => false if RUBY_PLATFORM =~ /linux/i
  gem 'libnotify', :require => false if RUBY_PLATFORM =~ /linux/i
end
group :production do
  gem 'pg'
end
