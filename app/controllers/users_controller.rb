class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @questions = @user.questions.order(created_at: :desc)
    @answers = @user.answers.order(created_at: :desc)
  end
end
