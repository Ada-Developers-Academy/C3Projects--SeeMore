class CreateStalkers < ActiveRecord::Migration
  def change
    create_table :stalkers do |t|
      t.string :username, null: false
      t.string :uid, null: false
      t.string :provider, null: false

      t.timestamps null: false
    end
  end
end
