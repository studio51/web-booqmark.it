class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |b|
      b.integer :user_id

      b.string :name
      b.string :url
      b.text   :description

      b.boolean :public, default: 0

      b.attachment :snapshot

      b.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
