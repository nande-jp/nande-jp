class CategoriesController < ApplicationController
  add_breadcrumb "ホーム", :root_path

  def index
    @answers = Answer.order(created_at: :desc)
                     .paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)

    add_breadcrumb 'カテゴリ一覧'
  end

  def show
    @answers = Answer.joins(:question)
                     .where(questions: {category: params[:id]})
                     .order(created_at: :desc)
                     .paginate(page: params[:page])

    @popular_questions = Question.where(category: params[:id]).order(answers_count: :desc).limit(10)

    add_breadcrumb 'カテゴリ一覧', categories_path
    add_breadcrumb I18n.t("activerecord.attributes.question.categories.#{params[:id]}")
  end
end
