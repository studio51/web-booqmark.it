class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.integer :taggings_count, default: 0
    end

    add_index :tags, :name, unique: true

    create_table :taggings do |t|
      t.references :tag

      t.references :taggable, polymorphic: true
      t.references :tagger,   polymorphic: true

      t.string :context, limit: 128

      t.datetime :created_at
    end

    add_index :taggings, [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type], unique: true, name: 'taggings_idx'
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
