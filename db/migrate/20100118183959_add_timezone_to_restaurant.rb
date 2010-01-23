class AddTimezoneToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :timezone, :string
  end

  def self.down
    remove_column :restaurants, :timezone
  end
end
