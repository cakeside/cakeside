container = Spank::Container.new
container.register(:configuration) { EnvironmentVariables.new }

container.register(:message_handler) { |builder| builder.build(PublishCakeToTwitter) }
container.register(:message_handler) { |builder| builder.build(ProcessPhoto) }

container.register(:queue) { |c| Delayed::Job }
container.register(:message_bus) { |c| c.build(MessageBus) }.as_singleton
container.register(:exif_parser) { |builder| ExifParser.new }
container.register(:twitter_publisher) { |c| c.build(TwitterPublisher) }.as_singleton
container.register(:blob_storage) { |builder| BlobStorage.new }

# repositories
container.register(:cakes) { |builder| Creation }
container.register(:photos) { |builder| Photo }

Spank::IOC.bind_to(container)
