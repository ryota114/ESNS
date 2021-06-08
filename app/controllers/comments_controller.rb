class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.post_id = post.id
    comment.user_id = current_user.id
    comment.save
    post.create_notification_comment(current_user, comment.id)
    redirect_to request.referer
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to request.referer
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
