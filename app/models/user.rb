class User < ActiveRecord::Base
  acts_as_tagger

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, inverse_of: :user, dependent: :destroy

  has_and_belongs_to_many :collections
  has_many :bookmarks
  has_many :tags, through: :bookmarks

  def name
    "#{profile.first_name} #{profile.last_name}"
  end

  def initials
    "#{profile.first_name.first}#{profile.last_name.first}"
  end
end
