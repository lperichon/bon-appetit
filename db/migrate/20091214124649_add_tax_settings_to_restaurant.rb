class AddTaxSettingsToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :include_tax, :boolean
    add_column :restaurants, :tax_value, :decimal, :precision => 3, :scale => 2
  end

  def self.down
    remove_column :restaurants, :include_tax
    remove_column :restaurants, :tax_value
  end
end
