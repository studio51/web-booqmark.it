class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |u|
      u.string   :email,                    null: false, default: ''
      u.string   :encrypted_password,       null: false, default: ''

      u.string   :reset_password_token
      u.datetime :reset_password_sent_at

      u.datetime :remember_created_at

      u.integer  :sign_in_count,            null: false, default: 0
      u.datetime :current_sign_in_at
      u.datetime :last_sign_in_at
      u.string   :current_sign_in_ip
      u.string   :last_sign_in_ip

      u.integer  :failed_attempts,          null: false, default: 0
      u.string   :unlock_token
      u.datetime :locked_at

      u.timestamps
    end

    add_index :users, [:email, :reset_password_token, :unlock_token], unique: true
  end

  def self.down
    drop_table :users
  end
end
