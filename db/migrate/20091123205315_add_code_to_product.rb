class AddCodeToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :code, :string
  end

  def self.down
    remove_column :products, :code
  end
end
