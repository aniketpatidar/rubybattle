class AddDefaultCreatedAtToRooms < ActiveRecord::Migration[7.0]
  def up
    execute("UPDATE rooms SET created_at = NOW() WHERE created_at IS NULL")
    change_column_null :rooms, :created_at, false
  end

  def down
    change_column_null :rooms, :created_at, true
  end
end
