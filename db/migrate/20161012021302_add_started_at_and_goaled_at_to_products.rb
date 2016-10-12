class AddStartedAtAndGoaledAtToProducts < ActiveRecord::Migration
  def change
    add_column :products, :started_at, :timestamp
    add_column :products, :goaled_at, :timestamp
  end
end
