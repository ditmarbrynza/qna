# frozen_string_literal: true

class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'question_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def follow
    stream_from 'questions'
  end
end
