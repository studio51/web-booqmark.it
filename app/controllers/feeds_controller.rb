class BookmarksController < ApplicationController
  respond_to :html, :json

  def index
    @bookmarks = Bookmark.where(public: true)
  end
end
