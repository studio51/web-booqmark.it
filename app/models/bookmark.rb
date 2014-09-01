class Bookmark < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_and_belongs_to_many :collections#, through: :associable

  validates_presence_of :name, :url
  validates_uniqueness_of :url, scope: :user

  validates :name, length: { minimum: 3, too_short: "requires at least %{count} characters" }
  validates :url, url: true
  validates :description, length: { maximum: 255, too_long: "%{count} characters is the maximum allowed" }

  def to_param

    "#{id} #{name}".parameterize
  end

  def self.for_user(user)
    user.bookmarks

    # self.includes(:user).where(bookmarks: {
    #   user_id: user
    # })
  end

  def self.tags(tag)

    self.includes(:tags).where(tags: {
      name: tag.split('-').join(' ')
    })
  end
end
