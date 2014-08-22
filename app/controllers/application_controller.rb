class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_header
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :extend_session_cookie
  helper_method :current_user, :user_signed_in?

  def user_session(session_key = cookies.signed[:raphael])
    @user_session ||= UserSession.authenticate(session_key)
  end

  def current_user
    user_session.try(:user)
  end

  def user_signed_in?
    current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:user) { |u| u.permit(:name, :city, :email) }
  end

  private

  def load_header
    @categories = Category.all
    @newest_tutorials = Tutorial.order(:created_at => :desc).limit(3)
    @newest_members = User.order(:created_at => :desc).limit(3)
    @top_members = User.order(:creations_count => :desc).limit(3)
  end

  def authenticate!
    redirect_to login_path unless user_session
  end

  def extend_session_cookie
    cookies.signed[:raphael] = user_session.access(request) if user_signed_in?
  end
end
