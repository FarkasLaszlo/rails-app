class CreateBlogsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs_categories, id: false do |t|
      t.belongs_to :blog, index: true
      t.belongs_to :category, index: true
    end
  end
end
