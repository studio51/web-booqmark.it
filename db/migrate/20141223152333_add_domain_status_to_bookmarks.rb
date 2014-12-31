class AddDomainStatusToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :status, :integer, default: 200
  end
end
