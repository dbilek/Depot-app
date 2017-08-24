class AddProductPriceToLineItems < ActiveRecord::Migration[5.0]
  def self.up
    add_column :line_items, :price, :decimal, :precision => 8, :scale => 2
    LineItem.all.each do |item|
      item.update_attributes :price => item.product.price
    end
  end

  def self.down
    remove_column :line_items, :price
  end
end
