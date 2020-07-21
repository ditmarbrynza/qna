class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only: %i[destroy]
  
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to question_url(@question)
    else
      render "questions/show"
    end
  end

  def destroy
    current_user.present? && current_user.author_of?(@answer.question)
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end