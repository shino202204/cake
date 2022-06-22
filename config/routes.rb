Rails.application.routes.draw do

  resources :orders, only:[:new, :comfirm, :complete, :create, :index, :show], controller: 'public/orders'
  post '/orders/confirm' => 'public/orders#confirm'
  post '/orders/complete' => 'public/orders#complete'

  resources :addresses, only:[:index, :edit, :create, :update, :destroy], controller: 'public/addresses'

  get 'items/' => 'public/items#index'
  get 'items/:id' => 'public/items#show', as: 'item'

  namespace :admin do
    # 管理者トップページ(注文履歴一覧画面)
    root to: 'homes#top'
    # onlyオプション：生成するルーティングを限定。不要なルーティングを実行しないようにする。
    resources :genres, only:[:index, :edit, :create, :update]
    resources :items, only:[:index, :show, :edit, :create, :update, :new]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end

  namespace :public do
    # get 'cart_items/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/unsubscribe'
  end

  # get '/customers' => "homes#top"
  # resources :customers, only:[:index, :show, :edit, :create, :destroy, :update, :new]
  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'

  get '/customers/my_page' => 'public/customers#show'
  get '/customers/edit' => 'public/customers#edit'
  patch '/customers' => 'public/customers#update'
  get '/customers/unsubscribe' => 'public/customers#unsubscribe'
  patch '/customers/withdraw' => 'public/customers#withdraw'

  get '/cart_items' => 'public/cart_items#index'
  post '/cart_items' => 'public/cart_items#create'
  patch '/cart_items/:id' => 'public/cart_items#update'

  # 以下の削除ルーティング：「:id」を先に記述すると
  # 「destroy_all」がidと認識されてしまいdestroyアクションに行ってしまう。
  # 先に「destroy_all」を記述すればdestroy_allアクションに行ってくれる。
  delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all'
  delete '/cart_items/:id' => 'public/cart_items#destroy'
  # resources :homes, only:[:top, :about]
  # resources :customers, only:[:edit, :unsubscribe]


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
