class BookmarkSnapshotJob < ActiveJob::Base
  queue_as :default

  # after_perform :notify_user

  # rescue_from(StandardError) do |exception|
  #   # notify_failed_job_to_user(exception)
  #   # notify_failed_job_to_admin(exception)
  # end

  # around_perform do |job, block|
  #   # do something before perform
  #   block.call
  #   # do something after perform
  # end

  def perform(bookmark)
    b = Bookmark.find(bookmark)

    # Get some arguments in place
    args = {
      height: 300,
      quality: 100
    }

    tmp_path = 'tmp/screens/bookmarks'
    tmp_name = "capture_#{b.id}"

    # Prepare the defaults
    html  = b.url.split('?')[0]
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

  # def notify_user
  #   flash[:notice] = "Bookmark was successfully re-generated. The new snapshot and status should be reflected"
  # end
end
