class BookmarkDeletionsController < ApplicationController
  def create
    @bookmark = current_user.bookmarks.find_by(answer_id: params[:answer_id])

    if @bookmark.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
