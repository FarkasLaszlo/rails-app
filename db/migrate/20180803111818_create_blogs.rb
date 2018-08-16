class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :publication_date
      t.text :content
      t.string :author
      t.integer :category
    end
  end
end
