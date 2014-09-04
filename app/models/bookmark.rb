class Bookmark < ActiveRecord::Base
  acts_as_taggable

  # Associations

  belongs_to :user

  has_and_belongs_to_many :collections

  # Validations

  validates_presence_of :name, :url
  validates_uniqueness_of :url, scope: :user

  validates :url, url: true
  validates :name, length:
    { minimum: 3, too_short: '' }
  validates :description, length:
    { maximum: 255, too_long: '' }

  # Methods

  def to_param
    "#{id} #{name}".parameterize
  end

  def self.for_user(user)
    user.bookmarks
  end

  def self.tags(tag)
    includes(:tags).where(tags:
      { name: tag.split('-').join(' ') })
  end
end
