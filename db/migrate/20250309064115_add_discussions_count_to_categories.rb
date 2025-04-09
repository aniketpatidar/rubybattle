class AddDiscussionsCountToCategories < ActiveRecord::Migration[7.1]
  def up
    add_column :categories, :discussions_count, :integer, default: 0, null: false

    # Update existing records
    execute <<-SQL
      UPDATE categories
      SET discussions_count = (
        SELECT COUNT(*)
        FROM categories_discussions
        WHERE categories_discussions.category_id = categories.id
      )
    SQL
  end

  def down
    remove_column :categories, :discussions_count
  end
end
