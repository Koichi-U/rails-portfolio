class UsersController < ApplicationController
  before_action :if_not_admin, only: [:admin, :user_list, :comment_list, :article_list, :tagging_list, :url_list, :tag_list, :admin_user_list]
  
  def show
    @taggings = Tagging.joins(tag: :user).where(users: { admin: false })
    @user = User.find(params[:id])
    user_comment_article_ids = Comment.where(user_id: current_user.id).select(:article_id).order(:article_id)
    @user_comment_articles = Article.where(id: user_comment_article_ids)
    @user_post_articles = Article.where(user_id: current_user.id)
    @comments = Comment.where(user_id: current_user.id)
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
  
  def tagging_list
    @taggings = Tagging.all
  end
  
  def url_list
    @urls = Url.all
  end
  
  def tag_list
    @tags = Tag.joins(:user)
  end
  
  def admin_user_list
    @users = User.where(admin: true)
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
