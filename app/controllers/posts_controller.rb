class PostsController < ApplicationController

  def index
    # 仮実装、想定はHOMEやジャンル・ブックマークなど各条件で表示する投稿を分岐させる予定
    @posts = Post.all.reverse_order
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    @posts = Post.all.reverse_order
    # redirect_to posts_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def ranking
  end

  def search
    @post = Post.new
    @search_posts = Post.search(params[:keyword])
    @search_users = User.search(params[:keyword])

    if @search_posts.present? || @search_users.present?
      @keyword = params[:keyword]
      render "search"
    else
      render "search"
    end
  end


  private

  def post_params
    params.require(:post).permit( :body, :genre, :post_image, :exercise_intensity, :exercise_time )
  end

end
