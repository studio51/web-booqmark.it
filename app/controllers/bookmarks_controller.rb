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
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # POST /collections
  def create
    new_params = bookmark_params.merge(user: current_user)

    @bookmark = Bookmark.new(new_params)
   # IMGKit.new(@bookmark.url).to_file('./tmp/pictures/temp-pic.png', size: 100, quality: 100)x

    url = @bookmark.url
    kit = IMGKit.new(url, height: 700)
    img = kit.to_img(:png)
    file = Tempfile.new(["template_#{@bookmark.id}", '.png'], 'tmp/pictures', encoding: "ascii-8bit")

    file.write(img)
    file.flush
    @bookmark.snapshot = file

    if @bookmark.save
      flash[:notice] = 'Success!'
      respond_with @bookmark
    else
      respond_with @bookmark, action: :new
    end

    file.unlink
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
    if bookmark.destroy
      flash[:notice] = 'Error'
      redirect_to bookmarks_path
    else
      flash[:notice] = 'Success'
      redirect_to bookmarks_path
    end
  end

  # Additional Methods

  def regenerate_snapshot
    @bookmark = Bookmark.find(params[:bookmark_id])
    url = @bookmark.url
    kit = IMGKit.new(url, height: 700)
    img = kit.to_img(:png)
    file = Tempfile.new(["#{@bookmark.id}", '.png'], 'tmp/pictures', encoding: "ascii-8bit")

    file.write(img)
    file.flush
    @bookmark.snapshot = file
    file.unlink


    if @bookmark.update(bookmark_params)
      flash[:notice] = "success"
      respond_with @bookmark, location: @bookmark
    else
      respond_with @bookmark, action: :edit
    end
  end

  private

    def bookmark
      @bookmark = Bookmark.for_user(current_user).find_by_id(params[:id])
    end

    def bookmark_params
      params.require(:bookmark).permit(
        :snapshot,
        :name,
        :url,
        :description,
        :tag_list,
        :user,
        collections: []
      )
    end
end
