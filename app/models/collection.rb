class Collection < ActiveRecord::Base

  has_attached_file :icon,
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/aws_s3.yml",
                    styles: {
                      xs: ['12x12#', :png],
                      lg: ['100x100#', :png]
                    }

  # validates_attachment_content_type :icon,
  #                                   content_type: /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :icon

  # Associations

  belongs_to :user, foreign_key: 'owner_id'

  has_and_belongs_to_many :users
  has_and_belongs_to_many :bookmarks

  # Methods

  #########
  # Gets all the Collections created by the User as Owner
  #
  # @param: owner_id
  #
  def self.for_owner(owner)
    owner.collections
  end

  #########
  # Gets all the Collections that the User is subscribed to
  #
  # @param: user_id
  #
  def self.for_user(user)
    includes(:users).where(collections_users:
      { user: user })
  end
end
