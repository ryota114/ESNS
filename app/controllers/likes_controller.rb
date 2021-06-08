class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    like = post.likes.new(user_id: current_user.id)
    like.save
    post.create_notification_like(current_user)
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    like = post.likes.find_by(user_id: current_user.id)
    like.destroy
    redirect_to request.referer
  end

end
