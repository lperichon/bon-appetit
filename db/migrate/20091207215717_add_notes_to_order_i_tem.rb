class AddNotesToOrderITem < ActiveRecord::Migration
  def self.up
    add_column :order_items, :notes, :text
  end

  def self.down
    remove_column :order_items, :notes
  end
end
