class CreateChallenges < ActiveRecord::Migration[7.1]
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.string :language
      t.text :tests
      t.text :method_template
      t.integer :difficulty, null: false

      t.timestamps
    end
  end
end
