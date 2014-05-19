class PublishCakeToTwitter
  def initialize(twitter_publisher)
    @twitter = twitter_publisher
  end

  def handles?(event)
    :new_creation_added == event
  end

  def handle(message)
    tweet_about(Creation.find(message[:creation_id]))
  end

  private

  def tweet_about(cake)
    @twitter.tweet(tweet_for(cake)) if cake.is_safe_for_children? && cake.published?
  end

  def tweet_for(cake)
    "#{cake.name} By #{cake.user.name} on https://www.cakeside.com/creations/#{cake.to_param}!"
  end

  handle_asynchronously :handle, run_at: Proc.new { 10.minutes.from_now }
end
