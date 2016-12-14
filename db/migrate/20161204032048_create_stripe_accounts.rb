class CreateStripeAccounts < ActiveRecord::Migration
  def change
    create_table :stripe_accounts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :publishable_key, null: false
      t.string :secret_key, null: false
      t.string :stripe_user_id, null: false

      t.timestamps null: false
    end
  end
end
