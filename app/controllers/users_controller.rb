class UsersController < ApplicationController
  before_action :check_user, except: [:new, :create]
  before_action :get_user, only: [:edit, :edit_password, :update_password, :update, :destroy, :show]
  before_action :has_access, only: [:edit, :edit_password, :update, :destroy]

  def index
    @keys =  ["name", "created_at", "email", "avatar", "level"]
    @users = User.all.order("created_at DESC")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to action: 'new', controller: 'sessions'
      flash[:notice] = "Successfully registrated"
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy!
    @user.remove_avatar! # TODO FL model feladatnak tűnik
    flash[:notice] = "Successfully deleted"
    redirect_to action: 'index'
  end

  def update
    if @user.update(user_params)
      redirect_to action: 'show'
      flash[:notice] = "Successfully updated"
    else
      render 'edit'
    end
  end

  def update_password
    @user.password_change = true
    if @user.update(user_params)
      redirect_to action: 'show'
      flash[:notice] = "Successfully updated password"
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

  def get_user
    @user = User.find_by(serial: params[:serial])
  end

  def check_user
    unless current_user
      redirect_to login_path
      flash[:danger] = "You have to login to do this"
    end
  end

  def has_access
    unless current_user.id == @user.id || current_user.admin?
      redirect_to users_path
      flash[:danger] = "You don't have rights to do this"
    end
  end
end
