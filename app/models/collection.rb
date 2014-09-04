class Collection < ActiveRecord::Base

  # Associations

  has_and_belongs_to_many :users
  has_and_belongs_to_many :bookmarks
end
