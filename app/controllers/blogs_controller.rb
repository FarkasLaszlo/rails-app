class BlogsController < ApplicationController
  include BlogsHelper

  before_action :check_user, except: [:index, :show]
  before_action :get_blog, only: [:edit, :update, :destroy, :show]
  before_action :has_access, only: [:edit, :update, :destroy]

  def index
    @keys = User.new.attributes.keys - ["created_at", "updated_at", "id"]
    @blogs = Blog.all.order("updated_at DESC")
  end

  def new
    @blog = Blog.new
  end

  def show
    @comments = Comment.where(blog_id: @blog.id).order("created_at DESC")
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.author = current_user.serial
    @blog.publication_date = localize(Time.now, format: "%Y %B %d %H:%M:%S", locale: "hu")
    if @blog.save!
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    if @blog.update!(blog_params)
      redirect_to action: 'show'
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy!
    redirect_to action: 'index'
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :category)
  end

  def get_blog
    @blog = Blog.find(params[:id])
  end

  def check_user
    unless current_user
      redirect_to blogs_path
    end
  end

  def has_access
    unless current_user.serial == @blog.author
      redirect_to blogs_path
    end
  end
end
