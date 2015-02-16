class FeedsController < ApplicationController
  respond_to :html, :json

  def index
    @bookmarks = bookmarks
  end

  private

  def bookmarks
    Bookmark.where(public: true)
  end
end
