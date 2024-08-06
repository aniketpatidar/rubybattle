class AddDiscussionToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :discussion, null: false, foreign_key: true
  end
end
