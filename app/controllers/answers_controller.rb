# frozen_string_literal: true

class AnswersController < ApplicationController
  include Voted
  before_action :authenticate_user!
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only: %i[update destroy best]

  after_action :publish_answer, only: [:create]

  def create
    authorize Answer
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    authorize @answer
    if current_user&.author_of?(@answer)
      @answer.update(answer_params)
    else
      redirect_to question_path(@answer.question), notice: 'You are not permitted.'
    end
  end

  def destroy
    authorize @answer
    if current_user&.author_of?(@answer)
      @answer.destroy
    else
      redirect_to question_path(@answer.question), notice: 'You are not permitted.'
    end
  end

  def best
    @question = @answer.question
    authorize @question
    @answer.set_the_best if current_user.author_of?(@question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast("answers_for_question_#{@question.id}", AnswerSerializer.new(@answer).as_json)
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[name url])
  end
end
