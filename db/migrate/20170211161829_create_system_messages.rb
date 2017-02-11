class CreateSystemMessages < ActiveRecord::Migration
  def change
    create_table :system_messages do |t|
      t.string :title, default: '件名未設定'
      t.text :body, default: '本文未設定'
      t.references :user, index: true, foreign_key: true
      t.integer :message_type, index: true

      t.timestamps null: false
    end
    add_index :system_messages, %i( user_id message_type ), unique: true
  end
end
