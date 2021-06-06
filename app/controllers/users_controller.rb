class UsersController < ApplicationController

  def my_page
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id])
    @relationship = current_user.following_relationships.find_by(follower_id: @user.id)
    @set_relationship = current_user.follower_relationships.new
  end

  def edit
    @user = current_user
  end

  def index
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to my_page_users_path
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.order(created_at: :desc).page(params[:page]).per(16)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.order(created_at: :desc).page(params[:page]).per(16)
  end

  def unsubscribe
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name,:introduction,:image)
  end

end
