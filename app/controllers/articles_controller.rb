class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @Urls = Url.all
  end

  def new
    @article = Article.new
    @tags = Tag.all
    @tag = Tag.new
    @tagging = Tagging.new
  end

  def create
    #投稿からURLを取り出すため
    article_content = Article.new(article_params)

    #OGP情報の取り出し
    ogp = OpenGraph.new(article_content.site_url)
    logger.debug(ogp.url)

    #OGP情報の保存
    url_create = Url.create({
      site_url: ogp.url,
      site_type: ogp.type,
      title: ogp.title,
      description: ogp.description,
      # site_name: ogp.site_name,
      image: ogp.images[0]
    })

    #直接全データを保存（複数アソシエーションができなかった）
    article = Article.new(title: article_content.title, text: article_content.text, site_url: article_content.site_url, url_id: url_create.id, user_id: current_user.id)

    if article.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
    @comment = Comment.new
  end

  def delete
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :site_url)
  end
end
