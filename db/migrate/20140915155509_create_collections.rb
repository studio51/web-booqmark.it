class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |c|
      c.string :name

      c.timestamps
    end
  end

  def self.down
    drop_table :collections
  end
end
