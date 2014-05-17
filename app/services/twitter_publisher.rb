class TwitterPublisher
  def initialize(configuration = ENV)
    @configuration = configuration
  end

  def publish(target)
    target.publish_message_with(create_client) unless Rails.env.test?
  end

  handle_asynchronously :publish

  private

  def create_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = @configuration["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = @configuration["TWITTER_CONSUMER_SECRET"]
      config.access_token        = @configuration["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = @configuration["TWITTER_ACCESS_SECRET"]
    end
  end
end
