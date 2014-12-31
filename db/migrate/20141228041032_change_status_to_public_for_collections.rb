class ChangeStatusToPublicForCollections < ActiveRecord::Migration
  def change
    remove_column :collections, :status
    add_column :collections, :public, :boolean, default: 0
  end
end
