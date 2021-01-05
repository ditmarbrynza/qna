# frozen_string_literal: true

class AnswerSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes %i[id question_id body created_at updated_at user_id best]
end
