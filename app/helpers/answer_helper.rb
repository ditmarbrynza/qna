# frozen_string_literal: true

module AnswerHelper
  def answer_author?(answer)
    current_user.id == answer.user_id
  end
end
