class MixpanelWorker < Struct.new(:name, :properties, :request_env)
  MIXPANEL_TOKEN = "866e150970370a95c77cf6293dbc02c5"

  def perform
    return unless Rails.env.production?
    @mixpanel = Mixpanel::Tracker.new(MIXPANEL_TOKEN, { :env => request_env })
    @mixpanel.track(name, properties)
  end
end
