class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # 今回、adminユーザーはseed.rbで作成するので、会員登録機能は不要です。なので、adminモデルからregisterabeをコメントアウトします。
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable
end
