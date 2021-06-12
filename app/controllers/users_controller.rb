class UsersController < ApplicationController

  def my_page
    @user = current_user
    # リクエストがあれば指定した月、なければ現在の月
    if params[:month]
      @month = Date.parse(params[:month])
    else
      @month = Time.zone.today
    end
    # 運動強度別運動時間
    very_soft = Post.where(user_id: current_user.id, exercise_intensity: "かなりゆるい", created_at: @month.all_month).group_by_day_of_month(:created_at).sum(:exercise_time)
    soft = Post.where(user_id: current_user.id, exercise_intensity: "ゆるい", created_at: @month.all_month).group_by_day_of_month(:created_at).sum(:exercise_time)
    nomal = Post.where(user_id: current_user.id, exercise_intensity: "普通", created_at: @month.all_month).group_by_day_of_month(:created_at).sum(:exercise_time)
    hard = Post.where(user_id: current_user.id, exercise_intensity: "ハード", created_at: @month.all_month).group_by_day_of_month(:created_at).sum(:exercise_time)
    very_hard = Post.where(user_id: current_user.id, exercise_intensity: "かなりハード", created_at: @month.all_month).group_by_day_of_month(:created_at).sum(:exercise_time)
    @all_exercise_time = [{name: "かなりゆるい", data: very_soft, stack: "exercise"},
                          {name: "ゆるい", data: soft, stack: "exercise"},
                          {name: "普通", data: nomal, stack: "exercise"},
                          {name: "ハード", data: hard, stack: "exercise"},
                          {name: "かなりハード", data: very_hard, stack: "exercise"}]
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
