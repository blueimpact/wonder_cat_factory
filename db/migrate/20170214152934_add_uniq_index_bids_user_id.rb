class AddUniqIndexBidsUserId < ActiveRecord::Migration
  def change
    remove_index :bids, :user_id
    remove_index :bids, :product_id

    add_index :bids, [:user_id, :product_id], unique: true
  end
end
