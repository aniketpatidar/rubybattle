class AddPostsCountToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :posts_count, :integer, default: 0
  end
end
