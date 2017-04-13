class CreateSystemMessages < ActiveRecord::Migration
  def change
    create_table :system_messages do |t|
      t.string :subject, null: false
      t.text :body, null: false
      t.references :user, index: true, foreign_key: true
      t.integer :message_type, index: true

      t.timestamps null: false
    end
    add_index :system_messages, %i( user_id message_type ), unique: true
  end
end
