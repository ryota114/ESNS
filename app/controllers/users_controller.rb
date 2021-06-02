class UsersController < ApplicationController

  def my_page
    @user = current_user
  end

  def show
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

  def follow
  end

  def follower
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
