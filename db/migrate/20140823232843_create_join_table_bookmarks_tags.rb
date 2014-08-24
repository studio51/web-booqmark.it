class CreateJoinTableBookmarksTags < ActiveRecord::Migration
  def change
    create_join_table :bookmarks, :tags do |t|
      # t.index [:bookmark_id, :tag_id]
      # t.index [:tag_id, :bookmark_id]
    end
  end
end
