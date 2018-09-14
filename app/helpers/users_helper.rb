module UsersHelper
  def user_avatar user
    image_tag((user.avatar? && user.avatar.url || "/placeholder-user.png"), class: "card-img-top")
  end

  def registration_date user
    localize(user.created_at ,format: "%Y %B %d %H:%M:%S", locale: "hu")
  end

  def user_levels
    User.levels
  end

  def user_has_right_to_write
    current_user && (current_user.vip? || current_user.admin?)
  end

end

