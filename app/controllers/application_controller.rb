class ApplicationController < ActionController::Base
  protect_from_forgery

  def resolve(target)
    target.new(current_user)
  end
end
