class CreateProductMessages < ActiveRecord::Migration
  def change
    create_table :product_messages do |t|
      t.string :subject, default: '件名未設定'
      t.text :body, default: '本文未設定'
      t.references :product, index: true, foreign_key: true, null: true
      t.integer :message_type, index: true

      t.timestamps null: false
    end

    add_index :product_messages, %i( product_id message_type ), unique: true
  end
end
