class Categories::AgesController < ApplicationController
  def show
    @answers = Answer.joins(question: :child)
                     .where("children.age = ? AND questions.category = ?", params[:id].to_i, Question.category_to_enum(params[:category_id]))
                     .paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)
  end
end
