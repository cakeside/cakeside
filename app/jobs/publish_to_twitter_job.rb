class PublishToTwitterJob < ActiveJob::Base
  queue_as :default

  def perform(cake)
    tweet_about(cake)
  end

  private

  def twitter
    @twitter ||= Spank::IOC.resolve(:twitter_publisher)
  end

  def tweet_about(cake)
    twitter.tweet(tweet_for(cake)) if cake.published?
  end

  def tweet_for(cake)
    "#{cake.name} By #{cake.user.name} on #{routes.cake_url(cake)}!"
  end

  def routes
    Cake::Application.routes.url_helpers
  end
end
