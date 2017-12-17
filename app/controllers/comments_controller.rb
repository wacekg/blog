class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(article_id: @article.id)
    @comment.attributes = comment_params
    if @comment.save
      session[:commenter] = @comment.commenter
      redirect_to article_path(@comment.article_id)
    else
      render 'articles/show'
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@comment.article_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :article_id)
  end
end
