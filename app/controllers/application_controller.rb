class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
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
    #@categories = Rails.cache.fetch("categories-#{Category.count}") do
      #Category.all
    #end
    @categories = Category.all
  end

  def load_user
    @user = current_user if current_user
  end
end
