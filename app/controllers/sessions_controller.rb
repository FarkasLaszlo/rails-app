class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:notice] = "notice.successfull login"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:notice] = "notice.successfull logout"
    redirect_to root_url
  end

end
