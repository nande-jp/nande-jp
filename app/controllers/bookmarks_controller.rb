class BookmarksController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @bookmarks = @user.bookmarks.order(created_at: :desc)
  end

  def create
    @bookmark = current_user.bookmarks.new(answer_id: params[:answer_id])
    @answer = @bookmark.answer

    respond_to do |format|
      if @bookmark.save
        format.js {}
        format.html { redirect_to root_path }
      else
        format.js {}
        format.html { redirect_to root_path }
      end
    end
  end
end
