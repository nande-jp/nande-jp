class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @answer = current_user.answers.new(answer_params.merge(question_id: params[:question_id]))

    if @answer.save
      ga_tracker.event(category: 'answer', action: 'add', label: @answer.id)
      redirect_to question_path(@answer.question_id)
    else
      redirect_to question_path(params[:question_id])
    end
  end
  private

  def answer_params
    params.require(:answer).permit(:category, :content, :points)
  end
end
