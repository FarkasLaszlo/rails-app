class DeleteDateAndPublicationDateFromCommentsAndBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :date
    remove_column :blogs, :publication_date
  end
end
