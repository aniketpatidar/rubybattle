class AddSlugToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :slug, :string
  end
end
