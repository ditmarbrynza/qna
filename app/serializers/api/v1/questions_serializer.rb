# frozen_string_literal: true

module Api
  module V1
    class QuestionsSerializer < ActiveModel::Serializer
      attributes %i[id title body created_at updated_at short_title user_id]

      def short_title
        object.title.truncate(7)
      end
    end
  end
end
