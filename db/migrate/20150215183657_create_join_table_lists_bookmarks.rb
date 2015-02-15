class CreateJoinTableListsBookmarks < ActiveRecord::Migration
  def change
    create_join_table :lists, :bookmarks
  end
end
