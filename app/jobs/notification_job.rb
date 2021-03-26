# frozen_string_literal: true

class NotificationJob < ApplicationJob
  queue_as :default

  def perform(question)
    Services::Notification.notify_question_subscribers(question)
  end
end
