class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
