class AddUnitPriceToOrderItem < ActiveRecord::Migration
  def self.up
    add_column :order_items, :unit_price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :order_items, :unit_price
  end
end
