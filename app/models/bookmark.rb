class Bookmark < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_and_belongs_to_many :collections

  validates_presence_of :name, :url
  validates_uniqueness_of :url, scope: :user

  validates :name, length: { minimum: 3, too_short: "requires at least %{count} characters" }
  validates :url, url: true
  validates :description, length: { maximum: 255, too_long: "%{count} characters is the maximum allowed" }

  def self.for_user(user)
    self.includes(:user).where(bookmarks: { user_id: user.id })
  end
end
