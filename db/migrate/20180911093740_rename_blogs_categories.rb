class RenameBlogsCategories < ActiveRecord::Migration[5.2]
  def change
    drop_table :blogs_categories
    create_table :categories_posts, id: false do |t|
      t.belongs_to :post, index: true
      t.belongs_to :category, index: true
    end
  end
end
