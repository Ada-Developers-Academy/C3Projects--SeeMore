class CreateInstagrams < ActiveRecord::Migration
  def change
    create_table :instagrams do |t|

      t.timestamps null: false
    end
  end
end
