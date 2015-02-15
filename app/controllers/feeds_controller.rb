class FeedsController < ApplicationController
  respond_to :html, :json

  def index
    collections
    bookmarks
  end

  private

  def collections
    Collection.where(public: true)
  end

  def bookmarks
    Bookmark.where(public: true)
  end
end
