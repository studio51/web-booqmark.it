class ChangeBookmarkNameToTypeString < ActiveRecord::Migration
  def change
    change_column :bookmarks, :url, :string
    change_column :bookmarks, :description, :text
  end
end
