class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: false do |t|
      t.belongs_to :user

      t.string :first_name
      t.string :last_name
    end
  end
end
