class Questions::AgesController < ApplicationController
  def show
    @questions = Question.joins(:child).where("children.age = ?", params[:id]).paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)
  end
end
