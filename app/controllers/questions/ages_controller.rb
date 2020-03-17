class Questions::AgesController < ApplicationController
  add_breadcrumb "ホーム", :root_path

  def show
    @answers = Answer.joins(question: :child)
                     .where("children.age = ?", params[:id].to_i)
                     .paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)

    add_breadcrumb "#{params[:id]}歳のギモン"
  end
end
