class PostsController < ApplicationController
  include PostsHelper

  before_action :check_user, except: [:index, :show]
  before_action :get_post, only: [:edit, :update, :destroy, :show]
  before_action :has_right_to_write, only: [:new, :create]
  before_action :has_access, only: [:edit, :update, :destroy]

  def index
    @posts = Post.filter_by params[:search]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    if @post.save
      redirect_to action: 'index'
      flash[:notice] = "Successfully created"
    else
      render 'new'
    end
  end

  def show
    @comments = @post.top_level_comments.includes(:user)
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Successfully updated"
      redirect_to action: 'show'
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy!
    flash[:notice] = "Successfully destroyed"
    redirect_to action: 'index'
  end

  private

  def has_right_to_write
    unless @user.vip? || @user.admin?
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit!
  end

  def get_post
    @post = Post.find(params[:id])
  end

  def check_user
    @user = current_user
    unless @user
      redirect_to login_path
      flash[:danger] = "You have to login to do this"
    end
  end

  def has_access
    unless @user == @post.user || @user.admin?
      redirect_to posts_path
    end
  end
end
