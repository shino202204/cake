Rails.application.routes.draw do
  namespace :admin do
    get 'genres/index'
    post 'genres/index' => 'genres#create'
    get 'genres/edit'
    get 'genres/:id/edit' => 'genres#edit'#, as: 'edit_genre'
    patch 'genres/:id/edit' => 'genres#update'
    get 'items/index'
    get 'item/new' => 'items#new'
    post 'item/new' => 'items#create'
    get 'item/:id' => 'items#show', as: 'item'
    get 'items/edit/:id' => 'items#edit', as: 'edit'
    # post 'genres' => 'genres#create', as: 'genre_create'
    get 'homes/top'
    # onlyオプション：生成するルーティングを限定。不要なルーティングを実行しないようにする。
    resources :admin, only:[:index, :show, :edit, :create, :destroy, :update]
    resources :genre, only:[:index, :show, :edit, :create, :destroy, :update]
    resources :item, only:[:index, :show, :edit, :create, :destroy, :update, :new]
    get '/' => 'homes#top'
    root to: 'homes#top'
  end
  # devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者用
  # URL/admin/sign_in...
  # devise_forの後に生成したコントローラーがどこに存在するかを記述
  # skipオプション：不要なルーティングであるパスワード変更・管理者側の登録を削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
    # genres: "admin/genres"
  }

end
