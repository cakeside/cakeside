class ConfigureContainerCommand
  def configure(container)
    container.register(:configuration) { EnvironmentVariables.new }
    container.register(:message_handler) { |builder| builder.build(PublishCakeToTwitter) }
    container.register(:message_handler) { |builder| builder.build(ProcessPhoto) }
    container.register(:message_handler) { |builder| builder.build(ProcessAvatar) }
    container.register(:queue) { |c| Delayed::Job }
    container.register(:message_bus) { |c| c.build(MessageBus) }.as_singleton
    container.register(:exif_parser) { |builder| ExifParser.new }
    container.register(:twitter_publisher) { |c| c.build(TwitterPublisher) }.as_singleton
    container.register(:product_api) { |c| AmazonAPI.new }.as_singleton
    if Rails.env.test?
      container.register(:blob_storage) { |builder| BlobStorage::Fake.new }
    else
      container.register(:blob_storage) { |builder| BlobStorage.new }
    end

    # repositories
    container.register(:cakes) { |builder| Creation }
    container.register(:photos) { |builder| Photo }
  end
end

if Rails.configuration.cache_classes
  container = Spank::Container.new
  ConfigureContainerCommand.new.configure(container)
  Spank::IOC.bind_to(container)
else
  ActionDispatch::Reloader.to_prepare do
    container = Spank::Container.new
    ConfigureContainerCommand.new.configure(container)
    Spank::IOC.bind_to(container)
  end
end
