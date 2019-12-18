class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @questions = Question.all
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to question_path(@question)
    else
      render :index
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:category, :content)
  end
end
