class BookmarksController < ApplicationController
  respond_to :html, :json

  # GET /collections
  def index
    tag_id ||= params[:id]

    bookmarks = Bookmark.for_user(current_user).order(created_at: :desc)
    bookmarks = bookmarks.tags(tag_id) if tag_id

    @bookmarks = paginate bookmarks

    respond_with @bookmarks
  end

  # GET /bookmarks/:id
  def show
    respond_with bookmark

    # @kit = IMGKit.new("http://www.google.co.uk")

    # format.jpg do
    #   send_data(@kit.to_jpg, :type => "image/jpeg", :disposition => 'inline')
    # end
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # POST /collections
  def create
    @bookmark = Bookmark.new(bookmark_params.merge(user: current_user))

    @bookmark.save
  end

  # GET /bookmarks/:id/edit
  def edit
    respond_with bookmark
  end

  # PATCH/PUT /bookmarks/:id
  def update
    respond_with bookmark.update(bookmark_params)
  end

  # DELETE /bookmarks/:id
  def destroy
    respond_with bookmark.destroy
  end

  private

    def bookmark
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
