source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'devise'
gem 'jquery-ui-rails'
gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem 'rmagick'
gem 'kaminari'
gem 'bootstrap-sass'
gem 'acts-as-taggable-on'
gem 'delayed_job', "~> 4.0.0.beta2"
gem 'delayed_job_active_record', "~> 4.0.0.beta3"
gem 'daemons'
gem 'jquery-fileupload-rails'
gem 'dotenv-rails'
gem 'airbrake'
gem 'geocoder'
gem 'pg'
gem 'asset_sync'

group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'rvm-capistrano'
  gem 'bullet'
  gem 'better_errors'
  gem 'lol_dba'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'teaspoon'
  gem 'rack-mini-profiler'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'fakes-rspec'
  gem 'simplecov'
  gem 'ffaker'
  gem 'selenium-webdriver'
  gem 'poltergeist'
end

group :staging do
  gem 'rack-mini-profiler'
end

group :production, :staging do
  gem 'fog'
  gem 'newrelic_rpm'
  gem 'dalli'
  gem 'unicorn'
end
