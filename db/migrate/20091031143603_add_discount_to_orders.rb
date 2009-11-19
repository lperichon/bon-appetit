class AddDiscountToOrders < ActiveRecord::Migration
  def self.up
    add_column :order_items, :discount, :decimal, :precision => 3, :scale => 2
    add_column :orders, :discount, :decimal, :precision => 3, :scale => 2
  end

  def self.down
    remove_column :orders, :discount
    remove_column :order_items, :discount
  end
end
