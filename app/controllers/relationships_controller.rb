class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow(@user)
    redirect_to request.referer
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to request.referer
  end

end
