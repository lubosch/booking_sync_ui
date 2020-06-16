module Twitter
  class ParseNewTweets < Service
    def call
      # TODO: Still waiting for twitter app approval
      client.home_timeline.each do |tweet|
        Tweet.create!(
          details: tweet,
          url: tweet['entities']['urls'][0]['url'],
          description: tweet['text'],
          created_at: Time.parse(tweet['created_at'])
        )
      end
    end

    protected

    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        config.bearer_token = ENV['TWITTER_BEARER_TOKEN']
      end
    end
  end
end
