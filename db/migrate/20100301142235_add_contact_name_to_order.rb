class AddContactNameToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :contact_name, :string
  end

  def self.down
    remove_column :orders, :contact_name
  end
end
