module SessionsHelper

  def log_in user
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.encrypted.permanent[:remember] = { value: "user_id: #{user.id}, token: #{user.remember_token}", httponly: true }
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (cookies.encrypted[:remember] && user_id = JSON.parse(cookies.encrypted[:remember])["user_id"])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(JSON.parse(cookies.encrypted[:remember])["token"])
        log_in user
        @current_user = user
      end
    end
  end

  def forget(user)
    user.forget
    cookies.delete(:remember)
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
