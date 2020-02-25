class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :record_pv, only: [:show]
  before_action :set_reg_wall, only: [:show]

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
      ga_tracker.event(category: 'question', action: 'add', label: @question.id)
      redirect_to question_path(@question.id)
    else
      flash[:alert] = @question.errors.full_messages[0]
      redirect_to root_path
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(bookmarks_count: :desc).paginate(page: params[:page])
    @related_questions = Question.where(category: @question.category).order(answers_count: :desc).order('RANDOM()').limit(10)
  end

  private

  def question_params
    params.require(:question).permit(:category, :content, :child_id)
  end
end
