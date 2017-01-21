class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :type, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
