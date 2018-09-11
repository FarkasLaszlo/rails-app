class DeleteAuthorFromBlogsAndComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :blogs, :author
    remove_column :comments, :author
  end
end
