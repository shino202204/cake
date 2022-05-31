Rails.application.routes.draw do
  namespace :admin do
    # 管理者トップページ(注文履歴一覧画面)
    root to: 'homes#top'

    # onlyオプション：生成するルーティングを限定。不要なルーティングを実行しないようにする。
    resources :genres, only:[:index, :show, :edit, :create, :destroy, :update]
    resources :items, only:[:index, :show, :edit, :create, :destroy, :update, :new]
  end

  # get '/customers' => "homes#top"
  # resources :customers, only:[:index, :show, :edit, :create, :destroy, :update, :new]
  root to: 'public/homes#top'

  # 管理者用
  # URL/admin/sign_in...
  # devise_forの後に生成したコントローラーがどこに存在するかを記述
  # skipオプション：不要なルーティングであるパスワード変更・管理者側の登録を削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
end
