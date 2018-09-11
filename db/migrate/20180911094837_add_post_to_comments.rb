class AddPostToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :post, foreign_key: true
    remove_reference :comments, :commentable, polymorphic: true, index: true
  end
end
