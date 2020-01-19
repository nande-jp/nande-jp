class UnsharesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @share = current_user.shares.find_by(answer_id: params[:answer_id])
    @answer = @share.answer

    respond_to do |format|
      if @share.destroy
        format.js {}
        format.html { redirect_to root_path }
      else
        format.js {}
        format.html { redirect_to root_path }
      end
    end
  end
end
