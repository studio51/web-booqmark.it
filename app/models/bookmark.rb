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

  has_and_belongs_to_many :collections, counter_cache: true

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
    # BookmarkSnapshotJob.perform_later(self.id)
    b = Bookmark.find(self.id)

    # Get some arguments in place
    args = {
      height: 300,
      quality: 100
    }

    tmp_path = 'tmp/screens/bookmarks'
    tmp_name = "capture_#{b.id}"

    # Prepare the defaults
    html  = b.url
    image = IMGKit.new(html, args).to_img(:png)

    # Create temporary file for paperclip
    tmp_file = Tempfile.new([tmp_name, '.png'], tmp_path, encoding: 'ascii-8bit')

    tmp_file.write(image)
    tmp_file.flush

    # Save the bookmark' image with paperclip
    b.snapshot = tmp_file
    b.save

    # Remove the temporary file/image
    tmp_file.unlink
  end

  # Import

  def import_bookmarks

  end
end
