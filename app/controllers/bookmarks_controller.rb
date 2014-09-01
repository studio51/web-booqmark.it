class BookmarksController < ApplicationController
  respond_to :html, :json

  def index
    if params[:id]
      bookmarks = Bookmark.tags(params[:id])
    else
      bookmarks = Bookmark
    end

    @bookmarks = paginate bookmarks.for_user(current_user).order(created_at: :desc)
    respond_with @bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params.merge(user: current_user))

    @bookmark.save
  end

  def show
    respond_with set_bookmark
  end

  def edit
    respond_with set_bookmark
  end

  def update
    respond_with set_bookmark.update(bookmark_params)
  end

  def destroy
    respond_with set_bookmark.destroy
  end

  private
    def set_bookmark
      @bookmark = Bookmark.for_user(current_user).find_by_id(params[:id])
    end

    def bookmark_params
      params.require(:bookmark).permit(
        :name,
        :url,
        :description,
        :tag_list,
        :user,
        collections: []
      )
    end
end
