class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type, null: false
      t.references :bid, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
