class AddSerialToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :serial, :string, null: false
    add_index :users, :serial, unique: true
  end
end
