class AgesController < ApplicationController
  add_breadcrumb "ホーム", :root_path

  def index
    @answers = Answer.order(created_at: :desc).paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)

    add_breadcrumb '年齢別'
  end
end
