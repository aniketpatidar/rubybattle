class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :code
      t.integer :status
      t.references :challenge, null: false, foreign_key: true

      t.timestamps
    end
    add_index :rooms, :code
  end
end
