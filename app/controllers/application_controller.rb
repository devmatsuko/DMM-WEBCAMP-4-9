class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後はマイページへ遷移するようにルーティングを変更
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  # サインアップ後はマイページへ遷移するようにルーティングを変更
  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  # サインアップ後はマイページへ遷移するようにルーティングを変更
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  # サインアップ時、ログイン時にnameフィールドのデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
