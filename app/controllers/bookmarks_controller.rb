class BookmarksController < ApplicationController
  respond_to :html, :json

  # GET /bookmarks
  def index
    bookmarks = paginate current_user.bookmarks.order(created_at: :desc)

    respond_to do |format|
      format.html { render partial: "bookmarks", locals: { bookmarks: bookmarks }}
      format.png {
        # kit = IMGKit.new("http://www.google.co.uk/", :quality => 50)
        # img = kit.to_img(:png)
        # img.to_file(Tempfile.new(["tmp_booqmark", '.png'], 'tmp/pictures', encoding: "ascii-8bit"))

        image = MiniMagick::Image.open("http://www.google.co.uk")
        image.contrast
        image.write("test.jpg")

      }
    end
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # POST /bookmarks
  def create
    new_params = bookmark_params.merge(user: current_user)

    @bookmark = Bookmark.new(new_params)

    if @bookmark.save
      flash[:notice] = 'Success!'
      redirect_to bookmarks_path
    else
      respond_with @bookmark, action: :new
    end
  end

  # GET /bookmarks/:id/edit
  def edit
    respond_with bookmark
  end

  # PATCH/PUT /bookmarks/:id
  def update
    if bookmark.update(bookmark_params)
      flash[:notice] = 'Error'
      respond_with bookmark
    else
      flash[:notice] = 'Success'
      respond_with bookmark, action: :new
    end
  end

  # DELETE /bookmarks/:id
  def destroy
    bookmark.destroy

    flash[:notice] = 'Error'
    redirect_to bookmarks_path
  end

  # Additional Methods

  private

    def bookmark
      @bookmark = Bookmark.for_user(current_user).find_by_id(params[:id])
    end

    def bookmark_params
      params.require(:bookmark).permit(
        :user,
        :name,
        :description,
        :url,
        :tag_list,
        :snapshot,
        collections: []
      )
    end
end
