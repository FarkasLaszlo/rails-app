class DeleteBlogIdAndParentIdFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_reference :comments, :blog
    remove_column :comments, :parent_id
  end
end
