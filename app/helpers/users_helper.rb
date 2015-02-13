module UsersHelper

  def user_presenter(user, size = 'sm')
    if user.avatar.nil?
      content_tag(:p, class: 'user-initials') do
        user.initials
      end
    else
      content_tag(:span, class: 'user-avatar') do
        image_tag "avatars/default/#{current_user.name.split(' ').join('-').downcase}.png", class: 'img-responsive'
      end
    end
  end
end
