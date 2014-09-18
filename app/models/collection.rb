class Collection < ActiveRecord::Base

  # Associations

  has_and_belongs_to_many :users
  has_and_belongs_to_many :bookmarks

  def self.for_user(user)
    includes(:users).where(users_collections:
      { user_id: user.id })
  end
end
