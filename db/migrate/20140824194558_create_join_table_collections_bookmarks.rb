class CreateJoinTableCollectionsBookmarks < ActiveRecord::Migration
  def change
    create_join_table :collections, :bookmarks do |t|
      # t.index [:collection_id, :bookmark_id]
      # t.index [:bookmark_id, :collection_id]
    end
  end
end
