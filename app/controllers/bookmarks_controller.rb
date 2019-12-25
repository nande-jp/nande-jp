class BookmarksController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @bookmarks = @user.bookmarks.order(created_at: :desc)
  end

  def create
    @bookmark = current_user.bookmarks.new(answer_id: params[:answer_id])

    if @bookmark.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
