module UsersHelper
  def user_avatar user
    user.avatar? && image_tag(user.avatar.url, class: "card-img-top") || image_tag("/placeholder-user.png", class: "card-img-top") # TODO elágazás az image_tag első paraméterében, a default avatar-t akár model szinten megfogalmazni
  end

  def registration_date user
    localize(user.created_at ,format: "%Y %B %d %H:%M:%S", locale: "hu")
  end

  def user_levels
    User.levels
  end

  def user_has_right_to_write
    (logged_user = current_user) && (logged_user.vip? || logged_user.admin?) # TODO FL na, itt tíz percig kergettem a logged_user-t... minek?
  end

end

