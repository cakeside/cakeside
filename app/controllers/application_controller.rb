class ApplicationController < ActionController::Base
  protect_from_forgery

  def command_for(command)
    command.new(current_user)
  end
end
