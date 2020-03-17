class UsersController < ApplicationController
  add_breadcrumb "ホーム", :root_path

  def show
    @user = User.find(params[:id])
    @posts = UserFeedService.new(user: @user, page: params.fetch(:page, 1)).get_feed
  end
end
