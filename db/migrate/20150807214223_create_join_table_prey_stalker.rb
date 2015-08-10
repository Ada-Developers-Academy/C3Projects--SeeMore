class CreateJoinTablePreyStalker < ActiveRecord::Migration
  def change
    create_join_table :prey, :stalkers do |t|
      t.index [:prey_id, :stalker_id]
      t.index [:stalker_id, :prey_id]
    end
  end
end
