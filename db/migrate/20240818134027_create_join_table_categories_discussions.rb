class CreateJoinTableCategoriesDiscussions < ActiveRecord::Migration[7.1]
  def change
    create_join_table :categories, :discussions do |t|
      t.index [:category_id, :discussion_id]
      t.index [:discussion_id, :category_id]
    end
  end
end
