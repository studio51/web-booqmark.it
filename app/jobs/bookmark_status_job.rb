class BookmarkStatusJob < ActiveJob::Base
  require 'net/http'

  queue_as :default

  after_perform :notify_user

  rescue_from(StandardError) do |exception|
    # notify_failed_job_to_user(exception)
    # notify_failed_job_to_admin(exception)
  end

  around_perform do |job, block|
    # do something before perform
    block.call
    # do something after perform
  end

  def perform(bookmark)
    b = Bookmark.find(bookmark)

    url      = URI(b.url)
    response = Net::HTTP.get_response(url)

    b.status = response.code
    b.save
  end

  def notify_user

  end
end
