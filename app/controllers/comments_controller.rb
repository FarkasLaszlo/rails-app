class CommentsController < ApplicationController
  before_action :get_comment, only: [:edit, :update, :destroy]
  before_action :check_user
  before_action :has_access, only: [:update, :edit, :destroy]

  def new
    @comment = params[:comment_id] && Comment.new(comment_id: params[:comment_id]) || Comment.new
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(id: @comment.post_id)
      flash[:notice] = "notice.successfully updated"
    else
      render 'edit'
    end
  end

  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id, post_id: params[:post_id], comment_id: params[:id]))
    if @comment.save
      redirect_to post_path(id: @comment.post_id)
      flash[:notice] = "notice.successfully created"
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy!
    flash[:notice] = "notice.successfully deleted"
    redirect_to post_path(id: @comment.post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def check_user
    unless current_user
      redirect_to login_path
      flash[:danger] = "danger.need_login"
    end
  end

  def has_access
    unless current_user == @comment.user || current_user.admin?
      redirect_to post_path(params[:post_id])
      flash[:danger] = "danger.no_access"
    end
  end
end
