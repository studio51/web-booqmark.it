class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles, id: false do |p|
      p.belongs_to :user

      p.string :first_name, null: true
      p.string :last_name,  null: true

      p.text   :description

      p.attachment :avatar
    end

    add_index :profiles, [:user_id, :first_name, :last_name, :avatar_file_name], unique: true, name: 'profiles_idx'
  end

  def self.down
    drop_table :profiles
  end
end
