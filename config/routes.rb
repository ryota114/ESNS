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
      get "my_page"  => "users#my_page"         #ユーザーのマイページ
      get "follow" => "users#follow"            #フォロー一覧
      get "follower" => "users#follower"        #フォロワー一覧
      get "unsubscribe" => "users#unsubscribe"  #退会画面の確認
      patch "withdraw" => "users#withdraw"      #退会処理、論理削除
    end
  end

  resources :posts, except: [ :new ] do
    collection do
      get "ranking"  => "posts#ranking" #投稿とフォロワーの人気ランキング
    end
    resource :bookmarks, only: [ :create, :destroy ]
    resource :likes, only: [ :create, :destroy ]
    resources :comments, only: [ :create, :destroy ]
  end


  resources :relationships, only: [ :create, :destroy ]
  resources :notifications, only: [ :index ]

end
