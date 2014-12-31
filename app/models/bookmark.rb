class Bookmark < ActiveRecord::Base
  acts_as_taggable

  has_attached_file :snapshot,
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/aws_s3.yml",
                    styles: {
                      sm: ['20x20#', :png],
                      md: ['45x45#', :png],
                      lg: ['96x96#', :png]
                    }

  # Associations

  belongs_to :user

  has_and_belongs_to_many :collections

  # Validations

  # validates_presence_of :name, :url
  # validates_uniqueness_of :url, scope: :user

  #validates :url, url: true
  # validates :name, length:
    # { minimum: 3, too_short: '' }
  # validates_presence_of :description

  do_not_validate_attachment_file_type :snapshot

  # Callbacks

  after_create :generate_snapshot

  # Scopes

  # Methods

  # Attributes

  # def to_param
  #   [id, name].join(' ').parameterize
  # end

  # Associations

  def self.for_user(user)
    user.bookmarks
  end

  def self.tags(tag)
    includes(:tags).where(tags:
      { name: tag.split('-').join(' ') })
  end

  # Jobs

  def check_domain_status
    BookmarkStatusJob.perform_later(self.id)
  end

  def generate_snapshot
    BookmarkSnapshotJob.perform_later(self.id)
  end
end
