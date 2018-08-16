class AddTimestampsToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:blogs)
  end
end
