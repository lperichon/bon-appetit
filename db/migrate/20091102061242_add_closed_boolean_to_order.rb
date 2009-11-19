class AddClosedBooleanToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :closed, :boolean
  end

  def self.down
    remove_column :orders, :closed
  end
end
