class PostsController < ApplicationController

  def index
    # 仮実装、想定はHOMEやジャンル・ブックマークなど各条件で表示する投稿を分岐させる予定
    @posts = Post.all.reverse_order
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @posts = Post.all.reverse_order
    if @post.save
    else
      # posts/error.js.erbを呼び出している
      render "error"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def ranking
    @posts = Post.includes(:liked_users).sort{|a,b| b.liked_users.count <=> a.liked_users.count }.first(4)
    @post_rank = 0
    @users = User.includes(:followers).sort{|a,b| b.followers.count <=> a.followers.count }.first(3)
    @user_rank = 0
  end

  def search
    @post = Post.new
    @search_posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "search"
  end


  private

  def post_params
    params.require(:post).permit( :body, :genre, :post_image, :exercise_intensity, :exercise_time )
  end

end
