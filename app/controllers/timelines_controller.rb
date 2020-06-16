class TimelinesController < ApplicationController
  def new
  end

  def create
    date_from = params[:date_from].present? ? Time.zone.parse(params[:date_from]) : 1.day.ago
    date_to = params[:date_to].present? ? Time.zone.parse(params[:date_to]) : Time.zone.now
    Twitter::SendBestOfTimeline.call(date_from, date_to, params[:email])
    flash[:notice] = 'Successfully sent'
    render 'new'
  end
end
