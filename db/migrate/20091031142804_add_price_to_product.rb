class AddPriceToProduct < ActiveRecord::Migration
  def self.up
    # precision is the total amount of digits
    # scale is the number of digits right of the decimal point
    add_column :products, :price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :products, :price
  end
end
