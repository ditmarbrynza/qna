class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy update]
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only: %i[update destroy]
  
  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    if current_user&.author_of?(@answer)
      @answer.update(answer_params)
    else
      redirect_to question_path(@answer.question), notice: 'You are not permitted.'
    end
  end

  def destroy
    if current_user&.author_of?(@answer)
      @answer.destroy
    else
      redirect_to question_path(@answer.question), notice: 'You are not permitted.'
    end
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
