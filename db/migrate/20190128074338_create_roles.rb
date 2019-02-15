class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.string :created_by
      t.string :update_by

      t.timestamps
    end
  end
end
