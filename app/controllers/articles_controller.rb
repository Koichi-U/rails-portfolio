class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all
    @urls = Url.all
    @taggings = Tagging.joins(tag: :user).where(users: { admin: true })
    logger.debug(@taggings)
  end


  def new
    #Articleの新規投稿 → #<Article:0x00007fee878c34a8 id: nil, title: nil, text: nil, site_url: nil, user_id: nil, url_id: nil, created_at: nil, updated_at: nil>
    @article = Article.new
    
    #Tagのbuild → #<Tagging:0x00007fee778ae900 id: nil, tag_id: nil, article_id: nil, user_id: nil, created_at: nil, updated_at: nil>
    #これがないとCSRF対策の認証が通らない
    @article.taggings.build
    
    #Tag一覧 → #[#<Tag:0x00007fee65ac6858 id: 1, name: "aaa", user_id: 1, created_at: Fri, 12 Aug 2022 23:57:55.260947000 JST +09:00, updated_at: Fri, 12 Aug 2022 23:57:55.260947000 JST +09:00>, #<Tag:0x00007fee65ac6790 id: 2, name: "bbb", user_id: 1, created_at: Sat, 13 Aug 2022 00:03:50.301607000 JST +09:00, updated_at: Sat, 13 Aug 2022 00:03:50.301607000 JST +09:00>]
    #TagはApplicatioinの方で定義
    
    #Tagの新規投稿 → #<Tag:0x00007fee87ba11e8 id: nil, name: nil, user_id: nil, created_at: nil, updated_at: nil>
    @tag = Tag.new
    
    #Taggingの新規投稿 → #<Tagging:0x00007fee87ba0fe0 id: nil, tag_id: nil, article_id: nil, user_id: nil, created_at: nil, updated_at: nil>
    @tagging = Tagging.new
    
  end


  def create
    #投稿からURLを取り出すため
    article = Article.new(article_params)

    #OGP情報の取り出し
    ogp = OpenGraph.new(article.site_url)
    image_alt = ogp.metadata.dig(:image, 0, :alt, 0, :_value)

    #OGP情報の保存
    url = Url.create({
      site_url: ogp.url,
      site_type: ogp.type,
      title: ogp.title,
      description: ogp.description,
      # site_name: ogp.site_name,
      image: ogp.images[0],
      image_alt: image_alt
    })

    #Articleにurl_idを保存
    article.url_id = url.id

    #配列で受け取ったtag_idを配列tag_listにint型で格納
    tags_array = params[:article][:tag_ids]
    tag_list = tags_array.map{|n| n.to_i}
    tag_list.delete(0)

    #保存できるかを示すため、保存するものを格納するようの変数
    tag_flag = true
    tag_data_array = []

    #mapを用いてtagを一つずつ保存する準備
    tag_list.map do |t|
      tag_post = article.taggings.build(tag_id: t)
      tag_data_array.append(tag_post)
      tag_flag = false unless tag_post.valid?
    end

    if article.valid? && url.valid? && tag_flag
      #DBへの保存(同時にbuildで関連づけられたデータも保存される)(urlは関係ないテーブルだが、buildで紐づけることで同時に保存できるようにした)
      article.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end


  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.where(user_id: current_user.id) if user_signed_in?
    @comment = Comment.new
  end


  def edit
  end


  def delete
  end


  private
  def article_params
    params.require(:article).permit(:title, :text, :site_url, employees_attributes: [{tag_ids: []}]).merge(user_id: current_user.id)
  end
end
