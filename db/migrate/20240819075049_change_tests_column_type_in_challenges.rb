class ChangeTestsColumnTypeInChallenges < ActiveRecord::Migration[7.1]
  def up
    change_column :challenges, :tests, :jsonb, using: 'tests::jsonb'
  end

  def down
    change_column :challenges, :tests, :text, using: 'tests::text'
  end
end
