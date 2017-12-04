class ReviewBroadcastJob < ApplicationJob
  queue_as :default

  def perform user, review
    ActionCable.server.broadcast "notification_channel_#{user.id}",
                                 notifications: render_notifications_for(user),
                                 message: 'has new review on ' + review.company.name + ' company',
                                 link: 'companies/'+review.company.id.to_s
  end

  private
  def render_notifications_for user
    ApplicationController.renderer.render partial: "activity_notification/socket_notifications",
                                          locals: {user: user}
  end
end
