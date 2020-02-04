class UnfollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @follow = Follow.find_by(follower_id: current_user.id, following_id: params[:user_id])

    if @follow && @follow.destroy
      ga_tracker.event(category: 'follow', action: 'delete', label: current_user.id
      redirect_to user_path(params[:user_id])
    else
      # redirect_to user_path(params[:user_id])
    end
  end
end
