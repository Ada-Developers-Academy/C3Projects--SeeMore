class DropGramsTable < ActiveRecord::Migration
  def change
    drop_table :grams
  end
end
