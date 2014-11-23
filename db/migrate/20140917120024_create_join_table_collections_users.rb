class CreateJoinTableCollectionsUsers < ActiveRecord::Migration
  def change
    create_join_table :collections, :users
  end
end
