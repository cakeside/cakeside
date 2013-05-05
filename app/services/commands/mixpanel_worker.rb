class MixpanelWorker < Struct.new(:name, :properties, :request_env)
  MIXPANEL_TOKEN = "7b1aa3b32ab81758228d1c95115cfc7e"

  def perform
    return unless Rails.env.production?
    @mixpanel = Mixpanel::Tracker.new(MIXPANEL_TOKEN, { :env => request_env })
    @mixpanel.track(name, properties)
  end
end
