class FunctionsController < ApplicationController

  def ajax_ogp
    url = params[:inputValue]
    logger.debug(url)

    ogp = OpenGraph.new(url)
    ogp.metadata = { site_url: nil, site_type: nil, title: nil, description: nil, image: nil } if ogp.metadata.empty?

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: ogp.metadata }
    end
  end

  def ajax_search
    search_word = params[:inputValue]

    @articles = Article.all
    @articles = @articles.joins(:url).where("site_title LIKE ? ", "%#{search_word}%") if search_word.present?

    # render partial: 'ajax_search', locals: { articles: @articles }

    respond_to do |format|
      format.js
      # format.json { render json: @articles }
    end
  end

end
