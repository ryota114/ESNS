class PostsController < ApplicationController

  def index
    # 仮実装、想定はHOMEやジャンル・ブックマークなど各条件で表示する投稿を分岐させる予定
    @posts = Post.order(created_at: "DESC").page(params[:page]).without_count.per(10)
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 非同期通信で投稿を追加するので、index側の@postsとの関係per(11)にしなければ投稿が１つ消えてしまう
    @posts = Post.order(created_at: "DESC").page(params[:page]).without_count.per(11)
    if @post.save
    else
      # posts/error.js.erbを呼び出している
      render "error"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
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
