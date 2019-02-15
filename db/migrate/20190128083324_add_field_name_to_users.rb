class AddFieldNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :isActivated, :boolean
    add_column :users, :key, :string
  end
end
