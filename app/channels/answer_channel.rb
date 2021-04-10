# frozen_string_literal: true

class AnswerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "answers_for_question_#{params['question_id']}"
  end
end
