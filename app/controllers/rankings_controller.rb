class RankingsController < ApplicationController
  add_breadcrumb "ホーム", :root_path

  def index
    @answers = Answer.order(:bookmarks_count, :shares_count).paginate(page: params[:page])

    @popular_questions = Question.order(answers_count: :desc).limit(10)

    add_breadcrumb '人気ランキング'
  end
end
