class CategoriesController < ApplicationController
  def show
    @answers = Answer.joins(:question)
                     .where(questions: {category: params[:id]})
                     .order(created_at: :desc)
                     .paginate(page: params[:page])

    @popular_questions = Question.where(category: params[:id]).order(answers_count: :desc).limit(10)
  end
end
