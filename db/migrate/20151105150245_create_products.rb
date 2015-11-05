class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.integer :price
      t.integer :goal
      t.date :closes_on
      t.integer :bids_count

      t.timestamps null: false
    end
  end
end
