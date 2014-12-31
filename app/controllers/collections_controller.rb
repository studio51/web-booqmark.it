class CollectionsController < ApplicationController

  # GET /collections
  def index
    # @collections = paginate current_user.collections
    @collections = Collection.paginate(page: params[:page])

  end

  # GET /collections/:id
  def show
    collection
    @bookmarks = collection.bookmarks.paginate(page: params[:page])
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/:id/edit
  def edit
    collection
  end

  # POST /collections
  def create
    @collection = Collection.new(collection_params.merge(owner_id: current_user.id))

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/:id
  def update
    respond_to do |format|
      if collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/:id
  def destroy
    collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(
        :owner_id,
        :name,
        :description,
        :public,
        :icon,
        user_ids: [],
        bookmark_ids: []
      )
    end
end
