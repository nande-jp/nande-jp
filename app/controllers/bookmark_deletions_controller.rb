class BookmarkDeletionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @bookmark = current_user.bookmarks.find_by(answer_id: params[:answer_id])
    @answer = @bookmark.answer

    respond_to do |format|
      if @bookmark.destroy
        ga_tracker.event(category: 'bookmark', action: 'delete', label: @answer.id)
        format.js {}
        format.html { redirect_to root_path }
      else
        format.js {}
        format.html { redirect_to root_path }
      end
    end
  end
end
