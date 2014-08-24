class User < ActiveRecord::Base
  acts_as_tagger

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bookmarks
  has_many :tags, through: :bookmarks
end
