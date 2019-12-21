class TopController < ApplicationController
  def index
    @answers = Answer.all.order(created_at: :desc)
  end
end
