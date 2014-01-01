class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_categories
  before_filter :load_tutorials
  before_filter :load_users
  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def load_categories
    @categories = Category.all
  end

  def load_tutorials
    @newest_tutorials = Tutorial.order(:created_at => :desc).limit(3)
  end

  def load_users
    @newest_members = User.order(:created_at => :desc).limit(3)
    @top_members = User.order(:creations_count => :desc).limit(3)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:user) { |u| u.permit(:name, :city, :email) }
  end
end

