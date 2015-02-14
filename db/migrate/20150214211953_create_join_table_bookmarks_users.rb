class CreateJoinTableBookmarksUsers < ActiveRecord::Migration
  def change
    create_join_table :bookmarks, :users
  end
end
