class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_categories
  before_filter :load_user
  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def resolve(target)
    target.new(current_user)
  end

  def load_categories
    @categories = Category.all
  end

  def load_user
    @user = current_user if current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:user) { |u| u.permit(:name, :city, :email) }
  end
end

