class Bookmark < ActiveRecord::Base
  acts_as_taggable

  has_attached_file :snapshot,
                    storage: :s3,
                    s3_credentials: proc { |a| a.instance.s3_credentials },
                    styles: {
                      xs: ['32x32#', :png],
                      sm: ['64x64#', :png],
                      md: ['128x128#', :png],
                      lg: ['300x300#', :png]
                    }

  # Associations

  belongs_to :user

  has_and_belongs_to_many :collections

  # Validations

  validates_presence_of :name, :url
  validates_uniqueness_of :url, scope: :user

  validates :url, url: true
  validates :name, length:
    { minimum: 3, too_short: '' }
  validates :description, length:
    { maximum: 255, too_long: '' }

  do_not_validate_attachment_file_type :snapshot

  # Methods

  def to_param
    "#{id} #{name}".parameterize
  end

  def s3_credentials
    {
      bucket: 'bookmark.it',
      access_key_id: 'AKIAJZBED22MAVJPRNAA',
      secret_access_key: '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',
      s3_host_name: 's3-eu-west-1.amazonaws.com'
    }
  end

  # def self.snapsnap
  #   kit = IMGKit.new(self.url).to_img(:jpg)
  #   file = Tempfile.new(
  #     ["template_#{id}", '.png'],
  #     'tmp/pictures',
  #     encoding: 'ascii-8bit'
  #   )

  #   file.write(kit)
  #   file.flush

  #   self.snapshot = file

  #   file.unlink
  # end

  def self.for_user(user)
    user.bookmarks
  end

  def self.tags(tag)
    includes(:tags).where(tags:
      { name: tag.split('-').join(' ') })
  end
end
