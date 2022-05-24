class ApplicationController < ActionController::Base
  # サインイン後にどこに遷移するかを設定しているメソッド(Deviseが用意している)
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_homes_top_path
    when User
      users_home_path
    end
  end
end
