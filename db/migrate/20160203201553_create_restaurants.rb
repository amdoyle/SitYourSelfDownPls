class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :owner_id
      t.integer :category_id
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :picture
      t.text :description
      t.integer :opening_time
      t.integer :closing_time
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
