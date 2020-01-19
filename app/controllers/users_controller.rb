class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = UserFeedService.new(user: @user, page: params.fetch(:page, 1)).get_feed
  end
end
