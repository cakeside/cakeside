class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :profile_application
  before_filter :load_categories

  private

  def resolve(target)
    target.new(current_user)
  end

  def profile_application
    Rack::MiniProfiler.authorize_request unless ENV['PROFILE_APPLICATION'].blank?
  end

  def load_categories
    @categories = Category.all
  end
end
