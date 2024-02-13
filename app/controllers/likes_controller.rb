class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = Article.find(params[:article_id])
    @like = current_user.likes.create(article: @article)
    if @like.save
      flash[:notice] = "Thanks for like this article!"
      redirect_to fallback_location: root_path
    else
      flash[:notice] = "You can not like this article!"
      redirect_to fallback_location: root_path
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    flash[:notice] = "You have unlike this article!"
    redirect_to fallback_location: root_path
  end
end
