class AnswersController < ApplicationController

  def show
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to question_answers_path(@answer)
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :body)
  end
end