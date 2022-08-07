class TagsController < ApplicationController
  before_action :authenticate_user!

  def create
    tag = Tag.new(tag_params)
    if tag.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
