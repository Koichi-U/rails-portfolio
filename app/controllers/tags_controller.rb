class TagsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tag = Tag.find_by(name: params[:name])
    # @article_ids = Tagging.where(tag_id: @tag.id)
    # @tagarticles = Article.joins(:tagging).where(tagging: { id: @tag.id })
    @tagarticles = Tagging.joins(:article, :tag).where(tag_id: @tag.id)
    @urls = Url.all
    @taggings = Tagging.joins(tag: :user).where(users: { admin: true })
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user_id = current_user.id
    if @tag.save
      redirect_back(fallback_location: root_path)
    else
      # Logger.debug('bbb')
    # binding.pry
      render template: "articles/new"
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
