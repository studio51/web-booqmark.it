class BookmarksController < ApplicationController
  respond_to :html, :json

  # GET /bookmarks
  def index
    # @filterrific = Filterrific.new(Bookmark,
    #   params[:filterrific] || session[:filterrific_bookmarks]
    # )

    # @filterrific.select_options = {
    #   sorted_by: Bookmark.all,
    #   with_tags: Tag.all.map { |t| [t.name, t.id] },
    #   with_collections: Collection.all.map { |c| [c.name, c.id] },
    # }

    bookmarks = current_user.bookmarks.order(created_at: :desc).paginate(page: params[:page], per_page: 10)

    # session[:filterrific_bookmarks] = @filterrific.to_hash

    respond_with @bookmarks = bookmarks

  rescue ActiveRecord::RecordNotFound
    redirect_to action: :reset_filterrific, format: :html && return
  end

  def reset_filterrific
    session[:filterrific_bookmarks] = nil

    redirect_to bookmarks_path
  end

  # GET /bookmarks/:id
  def show
    bookmark
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # POST /bookmarks
  def create
    new_params = bookmark_params.merge(user: current_user)

    @bookmark = Bookmark.new(new_params)
    # @bookmark.snapshot = @bookmark.get_snapshot

    if @bookmark.save
      flash[:notice] = t('messages.methods.create', model: 'bookmark', case: 'success')
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
      flash[:notice] = t('messages.methods.update', model: 'bookmark', case: 'error')
      respond_with bookmark
    else
      flash[:notice] = t('messages.methods.update', model: 'bookmark', case: 'success')
      respond_with bookmark, action: :new
    end
  end

  # DELETE /bookmarks/:id
  def destroy
    bookmark.destroy

    flash[:notice] = t('messages.methods.destroy', model: 'bookmark', case: 'success')
    redirect_to bookmarks_path
  end

  # Additional Methods

  def regenerate
    bookmark.generate_snapshot
    bookmark.check_domain_status

    flash[:notice] = t('messages.bookmarks.info.regenerate')

    redirect_to :back
  end

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
