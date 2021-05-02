module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      image_path 'avatar1.png'
    end
  end
end
