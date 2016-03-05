class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized


  def show
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def edit
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.blog_id = params[:blog_id]
    @comment.user = current_user
    authorize @comment

    if @comment.save
      redirect_to blog_path @comment.blog_id, notice: 'Comment Sent.'
    else
      @blog = @comment.blog
      render 'blogs/show'
    end
  end

  def update
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    authorize @comment
    if @comment.update(comment_params)
      redirect_to @blog
    else
      render 'edit'
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @blog, notice: 'Comment Removed.'}
      format.json { head :no_content, notice: 'Comment Removed.' }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
