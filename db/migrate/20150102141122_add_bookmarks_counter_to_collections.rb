class AddBookmarksCounterToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :bookmarks_count, :integer, default: 0
  end
end
