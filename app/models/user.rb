class User < ActiveRecord::Base
  acts_as_tagger

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations

  has_one :profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :collections
  has_many :bookmarks
  has_many :tags, through: :bookmarks
  has_many :lists, foreign_key: 'owner_id'

  has_and_belongs_to_many :lists

  # Validations

  validates_uniqueness_of :email

  # Attributes

  def initials
    [profile.first_name.first, profile.last_name.first].join
  end

  def avatar
    profile.avatar
  end

  def name
    [profile.first_name, profile.last_name].join(' ')
  end

  def description
    profile.description
  end
end
