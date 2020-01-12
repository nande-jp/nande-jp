class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    if params[:category]
      @questions = Question.where(category: params[:category]).order(created_at: :desc).paginate(page: params[:page])
    else
      @questions = Question.paginate(page: params[:page]).order(created_at: :desc)
    end

    @popular_questions = Question.order(answers_count: :desc).limit(10)
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
    @answers = @question.answers.order(created_at: :desc).paginate(page: params[:page])
    @related_questions = Question.where(category: @question.category).order(answers_count: :desc).order('RANDOM()').limit(20)
  end

  private

  def question_params
    params.require(:question).permit(:category, :content)
  end
end
