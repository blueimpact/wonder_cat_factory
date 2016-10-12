class AddProductIdToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :product, index: true, foreign_key: true

    reversible do |dir|
      dir.up do
        Event.includes(:bid).find_each do |event|
          event.update product_id: event.bid.product_id
        end
      end
    end
  end
end
