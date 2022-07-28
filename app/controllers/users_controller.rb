class UsersController < ApplicationController
  before_action :if_not_admin, only: [:admin, :user_list]
  def show
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: params[:id])
  end

  def admin
    
  end

  def user_list
    @users = User.all
  end


  def comment_list
    @comments = Comment.all
  end
  
  def article_list
    @articles = Article.all
  end
  
  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
