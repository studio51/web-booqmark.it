class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |b|
      b.belongs_to :user

      b.string :name
      b.string :url
      b.text   :description

      b.integer :status, default: 200
      b.boolean :public, default: false

      b.attachment :snapshot

      b.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
