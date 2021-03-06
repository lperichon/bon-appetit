class AddContactableFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthday, :date
  end

  def self.down
    remove_column :users, :birthday
    remove_column :users, :last_name
    remove_column :users, :middle_name
    remove_column :users, :first_name
  end
end
