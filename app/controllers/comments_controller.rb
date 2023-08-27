class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to opinion_path(@comment.opinion)
    else
      @opinion = @comment.opinion
      @comments = @opinion.comments
      render 'opinions/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, opinion_id: params[:opinion_id])
  end

end
