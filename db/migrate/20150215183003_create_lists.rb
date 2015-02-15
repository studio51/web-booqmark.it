class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |l|
      l.integer :owner_id,   null: false

      l.string :name,        null: false
      l.text   :description, null: false

      l.integer :users_count,     default: 0
      l.integer :bookmarks_count, default: 0

      l.attachment :icon

      l.timestamps  null: false
    end
  end
end
