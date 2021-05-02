module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      image_path 'avatar1.png'
    end
  end

  def questions_count(number)
    return "#{number} вопросов" if (number % 100).between?(11, 14)
    return "#{number} вопрос" if number % 10 == 1
    return "#{number} вопроса" if (number % 10).between?(2, 4)
    return "#{number} вопросов"
  end
end
