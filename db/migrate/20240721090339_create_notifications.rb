class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :read_at
      t.jsonb :params
      t.string :type

      t.timestamps
    end
  end
end
