class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |s|
      s.string     :var,    null: false
      s.text       :value
      s.references :target, null: false, polymorphic: true
      s.timestamps
    end

    add_index :settings, [
      :target_type,
      :target_id,
      :var
    ], unique: true
  end

  def self.down
    drop_table :settings
  end
end
