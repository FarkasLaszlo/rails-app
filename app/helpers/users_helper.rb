module UsersHelper
  def user_avatar user
    user.avatar? ? image_tag(user.avatar.url, class: "card-img-top") : image_tag("/placeholder-user.png", class: "card-img-top")
  end
end

