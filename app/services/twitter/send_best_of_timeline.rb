module Twitter
  class SendBestOfTimeline < Service
    attr_accessor :date_from, :date_to, :email

    def initialize(date_from, date_to, email)
      @date_from = date_from
      @date_to = date_to
      @email = email
    end

    def call
      message = {
        event: 'best_of_twitter',
        email: email,
        published_at: Time.zone.now,
        data: tweets_data
      }
      $kafka_producer.produce(message.to_json, topic: 'mailer')
    end

    protected

    def tweets_data
      ::Tweet.where(created_at: date_from..date_to).where.not(url: nil).find_each.map do |tweet|
        {
          url: tweet.url,
          description: tweet.description,
          created_at: tweet.created_at
        }
      end
    end
  end
end
