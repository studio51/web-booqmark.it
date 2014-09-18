class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  # GET /collections
  def index
    tag_id ||= params[:id]

    @collections = paginate Collection.for_user(current_user).order(created_at: :desc)

    respond_to do |format|
      format.html { render partial: "collections" }
    end
  end

  # GET /collections/:id
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/:id/edit
  def edit
  end

  # POST /collections
  def create
    @collection = Collection.new(collection_params.merge(users: [current_user]))

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
      if @collection.update(collection_params)
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
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(
        :name,
        users: [],
        bookmarks: []
      )
    end
end
