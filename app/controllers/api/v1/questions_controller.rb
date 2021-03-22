# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      def index
        @questions = Question.all
        render json: @questions, each_serializer: ::Api::V1::QuestionsSerializer
      end

      def show
        @question = Question.find(params['id'])
        render json: @question, serializer: ::Api::V1::QuestionSerializer
      end

      def answers
        @question = Question.find(params['question_id'])
        @answers = @question.answers
        render json: @answers, each_serializer: ::Api::V1::AnswersSerializer
      end
    end
  end
end
