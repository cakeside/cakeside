class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :profile_application
  before_filter :load_categories
  before_filter :load_user

  private

  def resolve(target)
    target.new(current_user)
  end

  def profile_application
    Rack::MiniProfiler.authorize_request if ENV['PROFILE_APPLICATION'] == true
  end

  def load_categories
    @categories = Rails.cache.fetch("categories") do
      Category.all
    end
  end

  def load_user
    @user = current_user if current_user
  end
end
