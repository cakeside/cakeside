class ConfigureContainerCommand
  def configure(container)
    container.register(:exif_parser) { |builder| ExifParser.new }
    container.register(:twitter_publisher) { |c| c.build(TwitterPublisher) }
    container.register(:product_api) { |c| AmazonAPI.new }.as_singleton
    if Rails.env.test?
      container.register(:blob_storage) { |builder| BlobStorage::Fake.new }
    else
      container.register(:blob_storage) { |builder| BlobStorage.new }
    end

    # repositories
    container.register(:cakes) { |builder| Creation::Repository.new }.as_singleton
    container.register(:photos) { |builder| Photo }
    container.register(:users) { |builder| User::Repository.new }.as_singleton
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
