class TaggingsController < ApplicationController
  def create
    # logger.debug(tagging_params["tag_id"])
    tag_id_array = tagging_params["tag_id"]
    tag_id_array.delete("0")
    logger.debug(tag_id_array)

    tagging_records = []
    # tag_id_array.each do |t|
    #   Tagging.create({ tag_id: t, article_id: "0" })
    # end
    
    Tagging.create({
      tag_id: "1", article_id: "0"
    })

    # logger.debug(tagging_records)

    # if Tagging.create(tagging_records)
      redirect_back(fallback_location: root_path)
    #   logger.debug("OK")
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  private
  def tagging_params
    params.require(:tagging).permit(tag_id: [])
  end
end
