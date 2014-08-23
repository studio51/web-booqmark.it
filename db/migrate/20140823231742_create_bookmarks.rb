class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|

      t.string :title
      t.text :url

      t.string :name
      t.string :description
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
