class AddColumnToBid < ActiveRecord::Migration
  def change
    add_column :bids, :paid_at, :datetime
  end
end
