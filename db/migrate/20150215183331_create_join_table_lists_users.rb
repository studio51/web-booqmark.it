class CreateJoinTableListsUsers < ActiveRecord::Migration
  def change
    create_join_table :lists, :users
  end
end
