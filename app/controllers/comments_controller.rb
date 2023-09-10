class CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

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

  def destroy
    if current_user == @comment.user
      @comment.destroy
      redirect_to opinion_path(@comment)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, opinion_id: params[:opinion_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
