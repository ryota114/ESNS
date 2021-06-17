class PostsController < ApplicationController

  def index
    # ジャンル、ブックマーク、自分の投稿及びフォロワーの投稿に分岐
    if params[:genre] == "ダイエット"
      @posts = Post.where(genre: "ダイエット").order(created_at: "DESC").page(params[:page]).without_count.per(10)
      @genre = "ダイエット"
    elsif params[:genre] == "筋トレ"
      @posts = Post.where(genre: "筋トレ").order(created_at: "DESC").page(params[:page]).without_count.per(10)
      @genre = "筋トレ"
    elsif params[:genre] == "スポーツ"
      @posts = Post.where(genre: "スポーツ").order(created_at: "DESC").page(params[:page]).without_count.per(10)
      @genre = "スポーツ"
    elsif params[:genre] == "生活"
      @posts = Post.where(genre: "生活").order(created_at: "DESC").page(params[:page]).without_count.per(10)
      @genre = "生活"
    elsif params[:genre] == "食事"
      @posts = Post.where(genre: "食事").order(created_at: "DESC").page(params[:page]).without_count.per(10)
      @genre = "食事"
    elsif params[:genre] == "その他"
      @posts = Post.where(genre: "その他").order(created_at: "DESC").page(params[:page]).without_count.per(10)
      @genre = "その他"
    elsif params[:bookmark]
      @posts = Post.where(user_id: current_user.id).order(created_at: "DESC").page(params[:page]).without_count.per(10)
      @genre = "自分の投稿"
    else
      @users = current_user.following
      @posts = Post.where(user_id: current_user.id).or(Post.where(user_id: @users.ids)).order(created_at: "DESC").page(params[:page]).without_count.per(10)
    end
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 非同期通信で投稿をcreate、def indexの@postsとの関係性によりper(11)にしなければ投稿が１つ消えてしまう
    if params[:genre] == "ダイエット"
      @posts = Post.where(genre: "ダイエット").order(created_at: "DESC").page(params[:page]).without_count.per(11)
      @genre = "ダイエット"
    elsif params[:genre] == "筋トレ"
      @posts = Post.where(genre: "筋トレ").order(created_at: "DESC").page(params[:page]).without_count.per(11)
      @genre = "筋トレ"
    elsif params[:genre] == "スポーツ"
      @posts = Post.where(genre: "スポーツ").order(created_at: "DESC").page(params[:page]).without_count.per(11)
      @genre = "スポーツ"
    elsif params[:genre] == "生活"
      @posts = Post.where(genre: "生活").order(created_at: "DESC").page(params[:page]).without_count.per(11)
      @genre = "生活"
    elsif params[:genre] == "食事"
      @posts = Post.where(genre: "食事").order(created_at: "DESC").page(params[:page]).without_count.per(11)
      @genre = "食事"
    elsif params[:genre] == "その他"
      @posts = Post.where(genre: "その他").order(created_at: "DESC").page(params[:page]).without_count.per(11)
      @genre = "その他"
    elsif params[:bookmark]
      @posts = Post.where(user_id: current_user.id).order(created_at: "DESC").page(params[:page]).without_count.per(11)
      @genre = "自分の投稿"
    else
      @users = current_user.following
      @posts = Post.where(user_id: current_user.id).or(Post.where(user_id: @users.ids)).order(created_at: "DESC").page(params[:page]).without_count.per(11)
    end
    
    if @post.save
    else
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
    @keyword = params[:keyword]
    @search_posts = Post.search(params[:keyword]).order(created_at: "DESC").page(params[:page]).without_count.per(10)
    render "search"
  end

  def bookmark
    @post = Post.new
    @bookmarks = Bookmark.where(user_id: current_user.id).order(created_at: "DESC").page(params[:page]).without_count.per(10)
  end


  private

  def post_params
    params.require(:post).permit( :body, :genre, :post_image, :exercise_intensity, :exercise_time )
  end

end
