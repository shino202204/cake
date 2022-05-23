Rails.application.routes.draw do
  # devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 管理者用
  # URL/admin/sign_in...
  # devise_forの後に生成したコントローラーがどこに存在するかを記述
  # skipオプション：不要なルーティングであるパスワード変更・管理者側の登録を削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

end
