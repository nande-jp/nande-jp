class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @follow = Follow.new(follower_id: current_user.id, following_id: params[:user_id])

    if @follow.save
      ga_tracker.event(category: 'follow', action: 'add', label: current_user.id)
      redirect_to user_path(params[:user_id])
    else
      redirect_to user_path(params[:user_id])
    end
  end
end
