class CreateProductMessages < ActiveRecord::Migration
  def change
    create_table :product_messages do |t|
      t.string :subject
      t.text :body
      t.references :product, index: true, foreign_key: true, null: false
      t.integer :message_type

      t.timestamps null: false
    end

    add_index :product_messages, %i( product_id message_type ), unique: true
  end
end
