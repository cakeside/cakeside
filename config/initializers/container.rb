container = Spank::Container.new
container.register(:configuration) { EnvironmentVariables.new }

container.register(:message_handler) { |builder| builder.build(PublishCakeToTwitter) }
container.register(:message_handler) { |builder| builder.build(ProccessPhoto) }

container.register(:queue) { |c| Delayed::Job }
container.register(:message_bus) { |c| c.build(MessageBus) }.as_singleton
container.register(:twitter_publisher) { |c| c.build(TwitterPublisher) }.as_singleton
container.register(:cakes) { |builder| Cake }

Spank::IOC.bind_to(container)
