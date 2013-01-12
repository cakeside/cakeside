require 'simplecov'
SimpleCov.start 'rails'

require 'rubygems'
require 'spork'



Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rails'
  require 'capybara/rspec'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include DeviseHelper, :type => :controller
  end
  module ::RSpec::Core
    class ExampleGroup
      include Capybara::DSL
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  ActiveSupport::Dependencies.clear
  FactoryGirl.reload
  Devise.stretches = 1
  Rails.logger.level = 4
end
