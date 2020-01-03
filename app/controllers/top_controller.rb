class TopController < ApplicationController
  def index
    @posts = HomeFeedService.new(user: user_signed_in? ? current_user : nil, page: params.fetch(:page, 1)).get_feed
  end
end
