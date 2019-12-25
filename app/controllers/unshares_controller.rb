class UnsharesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @share = current_user.shares.find_by(answer_id: params[:answer_id])

    if @share.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end
