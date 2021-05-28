Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root to: "homes#top"
  get "/about" => "homes#about"

  get "search" => "posts#search" #検索結果

  resources :users, only: [ :show, :edit, :index, :update] do
    collection do
      get "my_page"  => "users#my_page"     #ユーザーのマイページ
      get "unsubscribe" => "users#unsubscribe" #退会画面の確認
      patch "withdraw" => "users#withdraw"  #退会処理、論理削除
    end
  end

  resources :posts, except: [ :new ] do
    collection do
      get "ranking"  => "posts#ranking" #投稿とフォロワーの人気ランキング
    end
    resources :bookmarks, only: [ :create, :destroy ]
  end

  resources :comments, only: [ :create, :destroy ]
  resources :likes, only: [ :create, :destroy ]
  resources :relationships, only: [ :create, :destroy ]
  resources :notifications, only: [ :create, :index ]

end
