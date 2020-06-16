class ParseNewTweetsJob < ApplicationJob
  def perform
    Twitter::ParseNewTweets.call
  end
end
