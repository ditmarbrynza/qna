# frozen_string_literal: true

module Api
  module V1
    class AnswersSerializer < ActiveModel::Serializer
      attributes %i[id question_id body created_at updated_at best]
    end
  end
end
