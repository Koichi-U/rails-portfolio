class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_tag
  
  def set_tag
    @admintags = Tag.joins(:user).where(user: { admin: true }).order("name")
    @tags = Tag.joins(:user).where(user_id: current_user.id).order("name") if user_signed_in?
  end

  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :userimage])
  end
end
