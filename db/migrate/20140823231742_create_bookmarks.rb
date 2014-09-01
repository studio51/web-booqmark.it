class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user

      t.string :name
      t.string :url
      t.text :description

      t.timestamps null: false
    end
  end
end
