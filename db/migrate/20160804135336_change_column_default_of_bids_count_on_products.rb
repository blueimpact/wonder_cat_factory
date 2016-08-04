class ChangeColumnDefaultOfBidsCountOnProducts < ActiveRecord::Migration
  def change
    change_column_default :products, :bids_count, 0
  end
end
