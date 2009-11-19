class FreezeOrderData < ActiveRecord::Migration
  def self.up
    add_column :orders, :total, :decimal, :precision => 8, :scale => 2
    add_column :order_items, :subtotal, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :orders, :total
    remove_column :order_items, :subtotal
  end
end
