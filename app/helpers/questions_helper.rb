# frozen_string_literal: true

module QuestionsHelper
  def question_author?(question)
    current_user.id == question.user_id
  end
end
