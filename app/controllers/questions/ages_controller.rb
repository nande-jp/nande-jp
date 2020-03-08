class Questions::AgesController < ApplicationController
  def show
    @answers = Answer.joins(question: :child)
                     .where("children.age = ?", params[:id].to_i)
                     .paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)
  end
end
