class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all
    @Urls = Url.all
  end

  def new
    @article = Article.new
    @article.taggings.build
    @tags = Tag.joins(:user).where(user: { admin: true }).or(Tag.joins(:user).where(user_id: current_user.id))
    @tag = Tag.new
    @tagging = Tagging.new
  end

  def create
    #投稿からURLを取り出すため
    article = Article.new(article_params)

    #OGP情報の取り出し
    ogp = OpenGraph.new(article.site_url)

    #OGP情報の保存
    url_create = Url.create({
      site_url: ogp.url,
      site_type: ogp.type,
      title: ogp.title,
      description: ogp.description,
      # site_name: ogp.site_name,
      image: ogp.images[0]
    })

    #投稿からURLを取り出すため
    article.url_id = url_create.id

    #直接全データを保存（複数アソシエーションができなかった）
    # article = Article.new(title: article_content.title, text: article_content.text, site_url: article_content.site_url, url_id: url_create.id, user_id: current_user.id)

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
    params.require(:article).permit(:title, :text, :site_url, { tag_ids: [] }).merge(user_id: current_user.id)
  end
end
