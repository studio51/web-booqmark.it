class User < ActiveRecord::Base
  acts_as_tagger

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations

  has_one :profile, inverse_of: :user, dependent: :destroy

  has_many :collections, foreign_key: "owner_id"
  has_many :bookmarks
  has_many :tags, through: :bookmarks

  has_and_belongs_to_many :collections

  # Validations

  validates_presence_of :surname
  validates_uniqueness_of :surname

  has_settings do |s|
    s.key :authentication, defaults: {
      login: 'email'
    }

    s.key :application, defaults: {
      theme: 'default'
    }
  end

  def name
    "#{profile.first_name} #{profile.last_name}"
  end

  def initials
    "#{profile.first_name.first}#{profile.last_name.first}"
  end
end
