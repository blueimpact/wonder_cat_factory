class AddPublishableKeyAndSecretKeyAndStripeUserIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :publishable_key, :string, default: ""
    add_column :users, :secret_key, :string, default: ""
    add_column :users, :stripe_user_id, :string, default: ""
  end
end
