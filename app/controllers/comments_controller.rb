class CommentsController < ApplicationController
  before_action :get_comment, only: [:edit, :update, :destroy]
  before_action :get_blog, only: [:new, :update, :destroy, :create]
  before_action :check_user
  before_action :has_access, only: [:update, :edit, :destroy]

  def new
    @comment = Comment.new
  end

  def update
    if @comment.update(comment_params)
      redirect_to blog_path(@blog)
    else
      render 'edit'
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user.serial
    @comment.date = localize(Time.now, format: "%Y %B %d %H:%M:%S", locale: "hu")
    @comment.blog_id = params[:blog_id]
    if @comment.save
      redirect_to blog_path(@blog)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy!
    redirect_to blog_path(@blog)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def get_blog
    @blog = Blog.find(params[:blog_id])
  end

  def check_user
    unless current_user
      redirect_to login_path
    end
  end

  def has_access
    unless current_user.serial == @comment.author
      redirect_to blog_path(params[:blog_id])
    end
  end
end
