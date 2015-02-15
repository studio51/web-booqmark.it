class List < ActiveRecord::Base

  has_attached_file :icon,
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/aws_s3.yml",
                    styles: {
                      xs: ['12x12#', :png],
                      lg: ['100x100#', :png]
                    }

  do_not_validate_attachment_file_type :icon

  has_one :user, foreign_key: 'owner_id'

  has_and_belongs_to_many :users
  has_and_belongs_to_many :bookmarks
end
