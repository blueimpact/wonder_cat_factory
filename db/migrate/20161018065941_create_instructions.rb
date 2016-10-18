class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.string :type, null: false
      t.references :product, index: true, foreign_key: true
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
