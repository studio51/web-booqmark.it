class CreateJoinTableCollectionsBookmarks < ActiveRecord::Migration
  def change
    create_join_table :collections, :bookmarks
  end
end
