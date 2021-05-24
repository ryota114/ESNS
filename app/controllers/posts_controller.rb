class PostsController < ApplicationController

  def index
    # 仮実装、想定はHOMEやジャンル・ブックマークなど各条件で表示する投稿を分岐させる予定
    @posts = Post.all
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def ranking
  end


  private

  def post_params
    params.require(:post).permit( :user_id, :body, :genre, :post_image, :exercise_intensity, :exercise_time )
  end

end
