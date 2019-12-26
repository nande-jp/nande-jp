class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @answers = @user.answers.order(created_at: :desc)
  end
end
