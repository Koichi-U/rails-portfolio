class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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
    image_alt = ogp.metadata.dig(:image, 0, :alt, 0, :_value)

    #OGP情報の保存
    url_create = Url.create({
      site_url: ogp.url,
      site_type: ogp.type,
      title: ogp.title,
      description: ogp.description,
      # site_name: ogp.site_name,
      image: ogp.images[0],
      image_alt: image_alt
    })

    logger.debug(url_create)

    #直接全データを保存（複数アソシエーションができなかった）
    article = Article.new(title: article_content.title, text: article_content.text, site_url: article_content.url, url_id: url_create.id, user_id: current_user.id)

    if article.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.where(user_id: current_user.id)
    @comment = Comment.new
  end

  def edit
  end

  def delete
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :site_url)
  end
end
