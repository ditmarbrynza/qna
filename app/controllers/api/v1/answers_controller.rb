# frozen_string_literal: true

module Api
  module V1
    class AnswersController < Api::V1::BaseController
      def show
        @answer = Answer.find(params['id'])
        render json: @answer, serializer: ::Api::V1::AnswerSerializer
      end
    end
  end
end
