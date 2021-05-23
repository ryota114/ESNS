class PostsController < ApplicationController

  def index
    # 仮実装、想定はHOMEやジャンル・ブックマークなど各条件で表示する投稿を分岐させる予定
    @posts = Post.all
    @test= User.find(1)
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def ranking
  end

end
