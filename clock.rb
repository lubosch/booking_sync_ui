require 'clockwork'
require 'active_support/time' # Allow numeric durations (eg: 1.minutes)
require './config/boot'
require './config/environment'

Thread.report_on_exception = true

module Clockwork
  # every(1.minute, 'rate_app_notifiers') do
  # EnqueJobOnce.call(PendingChatMessageJob)
  # EnqueJobOnce.call(HiredLeadJob)
  # EnqueJobOnce.call(NewLeadJob)
  # EnqueJobOnce.call(NewDemandWithChatMessageJob)
  # end

  every(15.minutes, 'parse_new_tweets') do
    ParseNewTweetsJob.perform_later
  end

  error_handler do |error|
    Rails.logger.error(error)
  end
end
