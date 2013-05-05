class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_env

  private
  def initialize_env
    @request_env = {
      'REMOTE_ADDR' => request.env['REMOTE_ADDR'],
      'HTTP_X_FORWARDED_FOR' => request.env['HTTP_X_FORWARDED_FOR'],
      'rack.session' => request.env['rack.session'].to_hash,
      'mixpanel_events' => request.env['mixpanel_events']
    }
  end

  def resolve(target)
    target.new(current_user)
  end
end
