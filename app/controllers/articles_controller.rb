class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy, :summary]
  before_action :authoriza_article, only: [:edit, :update, :destroy]
  def index
    @articles = Article.includes(:author).order(created_at: :desc)
    @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
    respond_to do |format|
      format.json do
        render json: @articles
      end

      format.html do
        render
      end
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permitted_attributes(Article))
    @article.author = current_user
    if @article.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new(commenter: session[:commenter])
    @like = Like.find_or_initialize_by(article: @article, user: current_user)
  end

  def edit
  end

  def update
    if @article.update(permitted_attributes(@article))
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def summary
    respond_to do |format|
      format.json do
        render json: {
          id: @article.id,
          likes: @article.likes.count,
          comments: @article.comments.count
        }
      end
    end
  # end

end

  private

def authoriza_article
  authorize @article
end

  def find_article
    @article = Article.find(params[:id])
  end
end
