class MixpanelWorker < Struct.new(:name, :properties, :request_env, :user)
  MIXPANEL_TOKEN = "866e150970370a95c77cf6293dbc02c5"

  def perform
    return unless Rails.env.production?
    p "mixpanel: #{name}, #{properties}, #{request_env}, #{user}"
    @mixpanel = Mixpanel::Tracker.new(MIXPANEL_TOKEN, { :env => request_env })
    @mixpanel.track(name, properties)
    @mixpanel.set user.id, { :created => user.created_at, :name => user.name, :email => user.email } if user
  end
end
