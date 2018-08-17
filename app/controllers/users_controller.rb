class UsersController < ApplicationController
  before_action :check_user, except: [:new, :create]
  before_action :get_user, only: [:edit, :update, :destroy, :show]
  before_action :has_access, only: [:edit, :update, :destroy]

  def index
    @keys = User.new.attributes.keys - ["password_digest", "remember_digest", "updated_at", "id", "serial"]
    @users = User.all.order("created_at DESC")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy!
    @user.remove_avatar!
    redirect_to action: 'index'
  end

  def update
    if @user.update(user_params)
      redirect_to action: 'show'
    else
      render 'edit'
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def get_user
    @user = User.find_by(serial: params[:serial])
  end

  def check_user
    unless current_user
      redirect_to login_path
    end
  end

  def has_access
    unless current_user.id == @user.id
      redirect_to users_path
    end
  end
end
