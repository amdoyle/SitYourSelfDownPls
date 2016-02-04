class CreateFactories < ActiveRecord::Migration
  def change
    create_table :factories do |t|

      t.timestamps null: false
    end
  end
end
