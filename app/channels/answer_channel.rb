# frozen_string_literal: true

class AnswerChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'answer_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def follow
    stream_from 'answers'
  end
end
