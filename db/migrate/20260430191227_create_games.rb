class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :challenger, null: false, foreign_key: { to_table: :users }
      t.references :opponent,   null: false, foreign_key: { to_table: :users }
      t.references :winner,     null: true,  foreign_key: { to_table: :users }
      t.integer :status,      null: false, default: 0
      t.integer :round_count, null: false
      t.integer :difficulty,  null: false
      t.datetime :started_at
      t.datetime :completed_at
      t.timestamps
    end
  end
end
