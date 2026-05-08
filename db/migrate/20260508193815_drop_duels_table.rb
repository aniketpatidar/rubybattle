class DropDuelsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :duels
  end
end
