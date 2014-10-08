class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |c|
      c.integer :owner_id

      c.string :name
      c.text   :description

      c.boolean :status, default: 0

      b.attachment :icon

      c.timestamps
    end
  end

  def self.down
    drop_table :collections
  end
end
