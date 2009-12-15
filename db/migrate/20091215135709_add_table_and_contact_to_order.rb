class AddTableAndContactToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :table_id, :integer
    add_column :orders, :contact_id, :integer
  end

  def self.down
    remove_column :orders, :table_id
    remove_column :orders, :contact_id
  end
end
