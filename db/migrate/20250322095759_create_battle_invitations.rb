class CreateBattleInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :battle_invitations do |t|
      t.references :user, null: true, foreign_key: { to_table: :users }
      t.references :opponent, null: true, foreign_key: { to_table: :users }
      t.references :room, null: true, foreign_key: true
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
