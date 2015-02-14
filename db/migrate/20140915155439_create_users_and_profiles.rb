class CreateUsersAndProfiles < ActiveRecord::Migration
  def self.up
    create_table :users do |u|
      u.string :email,              null: false, default: ''
      u.string :encrypted_password, null: false, default: ''

      u.string   :reset_password_token
      u.datetime :reset_password_sent_at

      u.datetime :remember_created_at

      u.integer  :sign_in_count, default: 0, null: false
      u.datetime :current_sign_in_at
      u.datetime :last_sign_in_at
      u.string   :current_sign_in_ip
      u.string   :last_sign_in_ip

      u.integer  :failed_attempts, default: 0, null: false
      u.string   :unlock_token
      u.datetime :locked_at

      u.timestamps
    end

    add_index :users, [:email, :reset_password_token, :unlock_token], unique: true

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
    drop_table :users
    drop_table :profiles
  end
end
