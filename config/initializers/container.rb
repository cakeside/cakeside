container = Spank::Container.new
container.register(:configuration) { EnvironmentVariables.new }
container.register(:message_handler) { |builder| builder.build(PublishCakeToTwitter) }
container.register(:message_bus) { |c| MessageBus.new(c) }.as_singleton
container.register(:twitter_publisher) { |c| c.build(TwitterPublisher) }.as_singleton

Spank::IOC.bind_to(container)
