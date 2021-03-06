Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  root to: "homes#top"
  get "/about" => "homes#about"

  get "search" => "posts#search" # 検索結果
  get "bookmark" => "posts#bookmark" # ユーザーのブックマーク一覧

  resources :users, only: [:show, :edit, :index, :update] do
    member do
      get "following" => "users#following" # フォロー一覧
      get "followers" => "users#followers" # フォロワー一覧
    end
    collection do
      get "my_page" => "users#my_page" # ユーザーのマイページ
      get "unsubscribe" => "users#unsubscribe"  # 退会画面の確認
      patch "withdraw" => "users#withdraw"      # 退会処理、論理削除
    end
  end

  resources :posts, except: [:new] do
    collection do
      get "ranking" => "posts#ranking" # 投稿とフォロワーの人気ランキング
    end
    resource :bookmarks, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: [:index]
end
