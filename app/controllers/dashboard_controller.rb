class DashboardController < ApplicationController

  def index
    @collections = Collection.all
    @bookmarks = Bookmark.for_user(current_user).order(created_at: :desc)
    @tags = Tag.all

    @bookmark = Bookmark.new
  end
end
