class CategoriesController < ApplicationController
  add_breadcrumb "ホーム", :root_path

  def show
    @answers = Answer.joins(:question)
                     .where(questions: {category: params[:id]})
                     .order(created_at: :desc)
                     .paginate(page: params[:page])

    @popular_questions = Question.where(category: params[:id]).order(answers_count: :desc).limit(10)

    add_breadcrumb I18n.t("activerecord.attributes.question.categories.#{params[:id]}")
  end
end
