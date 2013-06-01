class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_env

  private

  def resolve(target)
    target.new(current_user)
  end
end
