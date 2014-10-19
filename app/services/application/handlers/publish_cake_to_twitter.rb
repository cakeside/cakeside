class PublishCakeToTwitter
  def initialize(twitter_publisher, cakes = Creation)
    @twitter = twitter_publisher
    @cakes = cakes
  end

  def handles?(event)
    :cake_published == event
  end

  def handle(message)
    tweet_about(@cakes.find(message[:cake_id]))
  end

  private

  def tweet_about(cake)
    @twitter.tweet(tweet_for(cake)) if cake.published?
  end

  def tweet_for(cake)
    "#{cake.name} By #{cake.user.name} on #{routes.cake_url(cake)}!"
  end

  def routes
    Cake::Application.routes.url_helpers
  end

  handle_asynchronously :handle, run_at: Proc.new { 10.minutes.from_now }
end
