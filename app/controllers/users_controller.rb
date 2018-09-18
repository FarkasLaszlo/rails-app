class UsersController < ApplicationController
  before_action :check_user, except: [:new, :create]
  before_action :get_user, only: [:edit, :update, :destroy, :show]
  before_action :get_current_user, only: [:edit_password, :update_password]
  before_action :has_access, only: [:edit, :edit_password, :update, :destroy]

  def index
    @keys =  ["name", "created_at", "email", "avatar", "level"]
    @users = User.all.order("created_at DESC")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to action: 'new', controller: 'sessions'
      flash[:notice] = "notice.successfully registrated"
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy!
    flash[:notice] = "notice.successfully deleted"
    redirect_to action: 'index'
  end

  def update
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "notice.successfully updated"
    else
      render 'edit'
    end
  end

  def update_password
    @user.password_change = true
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "notice.successfully updated password"
    else
      render 'edit_password'
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :current_password, :level)
  end

  def get_current_user
    @user = current_user
  end

  def get_user
    @user = User.find_by(serial: params[:serial])
  end

  def check_user
    unless current_user
      redirect_to login_path
      flash[:danger] = "danger.need_login"
    end
  end

  def has_access
    unless current_user.id == @user.id || current_user.admin?
      redirect_to users_path
      flash[:danger] = "danger.no_access"
    end
  end
end
