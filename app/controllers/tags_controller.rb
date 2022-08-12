class TagsController < ApplicationController
  before_action :authenticate_user!

  def create
    tag = Tag.new(tag_params)
    tag.user_id = current_user.id
    if tag.save
      # Logger.debug('aaa')
      redirect_back(fallback_location: root_path)
    else
      # Logger.debug('bbb')
      redirect_back(fallback_location: new_article_path)
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
