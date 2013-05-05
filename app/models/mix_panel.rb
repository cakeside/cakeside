class MixPanel
  def self.track(name, properties, env)
    # Notice we are using the 'mixpanel' queue
    Delayed::Job.enqueue MixpanelWorker.new(name, properties, env), queue: 'mixpanel'
  end
end
