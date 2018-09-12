class RenameBlogsCategories < ActiveRecord::Migration[5.2]
  def change
    drop_table :blogs_categories
    create_table :categories_posts, id: false do |t| # TODO FL próbáltad a #create_join_table metódust?
      t.belongs_to :post, index: true
      t.belongs_to :category, index: true
    end
  end
end
