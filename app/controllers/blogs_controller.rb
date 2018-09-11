class BlogsController < ApplicationController
  include BlogsHelper

  before_action :check_user, except: [:index, :show]
  before_action :get_blog, only: [:edit, :update, :destroy, :show]
  before_action :has_right_to_write, only: [:new, :create]
  before_action :has_access, only: [:edit, :update, :destroy]

  def index
    @keys = User.new.attributes.keys - ["created_at", "updated_at", "id"]
    @categories = Category.all
    @blogs = Blog.filter_by params[:search]
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params.merge(user_id: current_user.id))
    if @blog.save
      redirect_to action: 'index'
      flash[:notice] = "Successfully created"
    else
      render 'new'
    end
  end

  def show
    @comments = @blog.comments.includes(:user).order("created_at DESC")
  end

  def update
    if @blog.update(blog_params)
      redirect_to action: 'show'
      flash[:notice] = "Successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy!
    flash[:notice] = "Successfully destroyed"
    redirect_to action: 'index'
  end

  private

  def has_right_to_write
    unless @user.vip? || @user.admin?
      redirect_to blogs_path
    end
  end

  def blog_params
    params.require(:blog).permit!
  end

  def get_blog
    @blog = Blog.find(params[:id])
  end

  def check_user
    @user = current_user
    unless @user
      redirect_to login_path
      flash[:danger] = "You have to login to do this"
    end
  end

  def has_access
    unless @user == @blog.user || @user.admin?
      redirect_to blogs_path
    end
  end
end
