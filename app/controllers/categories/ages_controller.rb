class Categories::AgesController < ApplicationController
  add_breadcrumb "ホーム", :root_path

  def show
    @answers = Answer.joins(question: :child)
                     .where("children.age = ? AND questions.category = ?", params[:id].to_i, Question.category_to_enum(params[:category_id]))
                     .paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)

    add_breadcrumb I18n.t("activerecord.attributes.question.categories.#{params[:category_id]}"), category_path(params[:category_id])
    add_breadcrumb "#{params[:id]}歳"
  end
end
