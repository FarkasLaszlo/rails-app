class AddDefaultValueToUserLevel < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :level, :integer, default: 0
  end
end
