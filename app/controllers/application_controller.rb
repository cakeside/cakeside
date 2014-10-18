class ApplicationController < ActionController::Base
  include Pageable
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_header
  #before_action :extend_session_cookie
  helper_method :current_user, :user_signed_in?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def user_session(session_key = cookies.signed[:raphael])
    @user_session ||= UserSession.authenticate(session_key)
  end

  def current_user
    user_session.try(:user)
  end

  def user_signed_in?
    current_user
  end

  private

  def load_header
    @categories = Category.all
  end

  def authenticate!
    redirect_to login_path unless user_session
  end

  def extend_session_cookie
    cookies.signed[:raphael] = user_session.access(request) if user_signed_in?
  end

  def record_not_found
    redirect_to root_path, status: :moved_permanently
  end
end
