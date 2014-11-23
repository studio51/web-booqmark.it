class Profile < ActiveRecord::Base

  has_attached_file :avatar,
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/aws_s3.yml",
                    styles: {
                      xs: ['32x32#', :png],
                      sm: ['64x64#', :png],
                      md: ['128x128#', :png],
                    }

  belongs_to :user, inverse_of: :profile

  validates_presence_of :first_name, :last_name
end
