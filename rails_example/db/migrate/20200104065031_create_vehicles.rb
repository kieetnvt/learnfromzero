class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :type, null: false
      t.string :color
      t.integer :price
      t.boolean :purchased, default: false
    end
  end
end
