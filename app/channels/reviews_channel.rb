class ReviewsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'reviews'
  end
end