class CommentsController < ApplicationController
  before_action :get_comment, only: [:edit, :update, :destroy]
  before_action :get_blog, only: [:new, :update, :destroy, :create]
  before_action :check_user
  before_action :has_access, only: [:update, :edit, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :error_handler
  rescue_from ActionController::UrlGenerationError, with: :error_handler

  def new
    commentable_type = params[:comment_id] && "Comment" || "Blog"
    @comment = Comment.new(commentable_type: commentable_type, commentable_id: params[:comment_id] || params[:blog_id])
  end

  def update
    if @comment.update(comment_params)
      redirect_to blog_path(@blog)
      flash[:notice] = "Successfully updated"
    else
      render 'edit'
    end
  end

  def create
    @comment = (Comment.find_by(id: params[:comment_id]) || @blog).comments.build(comment_params.merge(user_id: current_user.id))
    if @comment.save
      redirect_to blog_path(@blog)
      flash[:notice] = "Successfully created"
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy!
    flash[:notice] = "Successfully deleted"
    redirect_to blog_path(@blog)
  end

  private

  def error_handler
    redirect_to "javascript:history.back()"
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def get_comment
    @comment = Comment.find(params[:id] || params[:comment_id])
  end

  def get_blog
    @blog = Blog.find(params[:blog_id])
  end

  def check_user
    unless current_user
      redirect_to login_path
      flash[:danger] = "You have to login to do this"
    end
  end

  def has_access
    unless current_user == @comment.user || current_user.admin?
      redirect_to blog_path(params[:blog_id])
      flash[:danger] = "You don't have rights to do this"
    end
  end
end
