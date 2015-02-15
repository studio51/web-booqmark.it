class Profile < ActiveRecord::Base

  has_attached_file :avatar,
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/aws_s3.yml",
                    styles: {
                      sm: ['32x32#', :png],
                      md: ['64x64#', :png],
                    }

  belongs_to :user

  do_not_validate_attachment_file_type :avatar

  validates_presence_of :first_name
end
