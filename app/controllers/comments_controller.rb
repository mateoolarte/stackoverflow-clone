class CommentsController < ApplicationController
  def create
    @commentable.comments.create(comments_params)

    redirect_to question_path(params[:question_id])
  end

  private
  def comments_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
