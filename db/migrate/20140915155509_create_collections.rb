class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |c|
      c.integer :owner_id

      c.string :name, null: false
      c.text   :description

      c.boolean :public, default: true

      c.integer :bookmarks_count, default: 0

      c.attachment :icon

      c.timestamps
    end
  end

  def self.down
    drop_table :collections
  end
end
