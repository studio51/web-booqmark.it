class Bookmark < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user

  def self.for_user(user)
    self.includes(:user).where(bookmarks: { user_id: user.id })
  end
end

