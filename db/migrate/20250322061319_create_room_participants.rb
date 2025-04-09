class CreateRoomParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :room_participants do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :subscription_status, default: 0

      t.timestamps
    end
  end
end
