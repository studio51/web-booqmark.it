module UsersHelper

  def user_presenter(user, size = 'sm')
    if user.avatar.nil?
      content_tag(:p, class: 'user-initials') do
        user.initials
      end
    else
      image_tag user.avatar, class: 'img-responsive'
    end
  end
end
