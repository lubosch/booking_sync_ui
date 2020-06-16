require 'rails_helper'

describe Twitter::SendBestOfTimeline do
  subject { described_class.call(date_from, date_to, email) }
  let(:date_from) { Time.zone.parse('2020/02/02') }
  let(:date_to) { Time.zone.parse('2020/02/03') }
  let(:email) { 'john@wick.com' }
  let!(:tweet) do
    Tweet.create!(url: 'google.com', description: 'Short description', created_at: Time.zone.parse('2020/02/02 12:30'))
  end

  it 'broadcasts best tweets to kafka' do
    allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2020/02/02 12:30'))
    expect($kafka_producer).to receive(:produce).with(
      {
        event: 'best_of_twitter', email: 'john@wick.com', published_at: Time.zone.parse('2020/02/02 12:30'),
        data: [
          url: 'google.com',
          description: 'Short description',
          created_at: Time.zone.parse('2020/02/02 12:30')
        ]
      }.to_json,
      topic: 'mailer'
    )
    subject
  end
end
