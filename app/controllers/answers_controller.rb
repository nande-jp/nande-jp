class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(answer_params.merge(question_id: params[:question_id]))

    if @answer.save
      redirect_to question_path(@answer.question_id)
    else
      redirect_to question_path(params[:question_id])
    end
  end
  private

  def answer_params
    params.require(:answer).permit(:category, :content)
  end
end
