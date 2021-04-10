# frozen_string_literal: true

class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_for_question_#{params['question_id']}"
  end
end
