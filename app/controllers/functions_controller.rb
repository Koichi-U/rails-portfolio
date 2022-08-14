class FunctionsController < ApplicationController

  def ajax_ogp
    url = params[:inputValue]
    logger.debug(url)

    ogp = OpenGraph.new(url)
    ogp.metadata = { site_url: nil, site_type: nil, title: nil, description: nil, image: nil } if ogp.metadata.empty?
    
    # ogp = { id:1, nickname: "ぴよっち", age: 22 }

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: ogp.metadata }
    end
  end

end
