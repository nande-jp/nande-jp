class SharesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @shares = @user.shares.order(created_at: :desc)
  end

  def create
    @share = current_user.shares.new(answer_id: params[:answer_id])
    @answer = @share.answer

    respond_to do |format|
      if @share.save
        ga_tracker.event(category: 'share', action: 'add', label: @answer.id)
        format.js {}
        format.html { redirect_to root_path }
      else
        format.js {}
        format.html { redirect_to root_path }
      end
    end
  end
end
