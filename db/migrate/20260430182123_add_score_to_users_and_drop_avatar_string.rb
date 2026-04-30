class AddScoreToUsersAndDropAvatarString < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :avatar, :string
    add_column :users, :score, :integer, default: 0, null: false
  end
end
