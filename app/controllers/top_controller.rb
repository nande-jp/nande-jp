class TopController < ApplicationController
  def index
    @posts = HomeFeedService.new(user: user_signed_in? ? current_user : nil, page: params.fetch(:page, 1)).get_feed
    @popular_questions = Question.order(answers_count: :desc).order('RANDOM()').limit(10)
  end
end
