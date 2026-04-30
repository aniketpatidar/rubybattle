class CreateGameRounds < ActiveRecord::Migration[7.1]
  def change
    create_table :game_rounds do |t|
      t.references :game,         null: false, foreign_key: true
      t.references :challenge,    null: false, foreign_key: true
      t.references :round_winner, null: true,  foreign_key: { to_table: :users }
      t.text    :challenger_code
      t.text    :opponent_code
      t.integer :round_number, null: false
      t.datetime :completed_at
      t.timestamps
    end
  end
end
