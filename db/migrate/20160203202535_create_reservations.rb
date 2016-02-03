class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :name
      t.integer :number
      t.datetime :time

      t.timestamps null: false
    end
  end
end
