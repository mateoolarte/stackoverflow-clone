class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @votable.votes.create(user: current_user)

    redirect_to question_path(params[:question_id])
  end

  def destroy
    @votable.votes.where(user: current_user).take.try(:destroy)

    redirect_to question_path(params[:question_id])
  end
end
