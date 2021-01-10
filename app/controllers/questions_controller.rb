# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Voted
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show update destroy]

  after_action :publish_question, only: [:create]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answers = @question.answers
    @answer.links.new

    gon.push(
      current_user: current_user&.id,
      question_owner: @question.user.id,
      question_id: @question.id
    )
  end

  def new
    @question = Question.new
    @question.links.new
    @award = Award.new(question: @question)
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    redirect_to @question, notice: 'Your question successfully created.' if @question.save
  end

  def update
    if current_user&.author_of?(@question)
      @question.update(question_params)
    else
      redirect_to question_path(@question), notice: 'You are not permitted.'
    end
  end

  def destroy
    if current_user&.author_of?(@question)
      @question.destroy
      redirect_to root_path, notice: 'Your question successfully deleted.'
    else
      redirect_to root_path, notice: 'You are not permitted.'
    end
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast('questions', QuestionSerializer.new(@question).as_json)
  end

  def question_params
    params.require(:question).permit(
      :title,
      :body,
      files: [],
      links_attributes: %i[name url],
      award_attributes: %i[title image]
    )
  end
end
