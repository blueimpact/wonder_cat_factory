class AddPicturesCountToProduct < ActiveRecord::Migration
  def change
    add_column :products, :pictures_count, :integer, default: 0

    reversible do |dir|
      dir.up do
        Product.find_each do |product|
          Product.reset_counters(product.id, :pictures)
        end
      end
    end
  end
end
