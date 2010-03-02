class AddSubtotalToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :subtotal, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :orders, :subtotal
  end
end
