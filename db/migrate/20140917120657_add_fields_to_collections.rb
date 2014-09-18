class AddFieldsToCollections < ActiveRecord::Migration
  def change

    add_column :collections, :description, :text
    add_column :collections, :status, :boolean, default: 0
    add_column :collections, :owner_id, :integer
  end
end
