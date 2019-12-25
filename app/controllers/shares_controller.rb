class SharesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @shares = @user.shares.order(created_at: :desc)
  end

  def create
    @share = current_user.shares.new(answer_id: params[:answer_id])

    if @share.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
