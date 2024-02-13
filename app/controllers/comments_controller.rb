class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]


  # POST /comments or /comments.json
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html {
          redirect_to article_url(@article)
          flash[:success] = "Comment was successfully created."
        }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html {
          redirect_to article_url(@article)
          flash[:danger] = "Please sign in or sign up!."
        }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html {
          redirect_to comment_url(@comment)
          flash[:success] = "Comment was successfully updated."
        }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html {
          render :edit,
          flash[:danger] = "Sorry, You can not delete this comment!"
        }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @article = Article.find(params[:article_id])
    @comment.destroy!

    respond_to do |format|
      format.html {
        redirect_to article_url(@article)
        flash[:danger] = "Comment was successfully destroyed."
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:article_id, :user_id, :commentBody)
    end
end
