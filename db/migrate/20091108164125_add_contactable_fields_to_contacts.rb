class AddContactableFieldsToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :first_name, :string
    add_column :contacts, :middle_name, :string
    add_column :contacts, :last_name, :string
    add_column :contacts, :birthday, :date
  end

  def self.down
    remove_column :contacts, :last_name
    remove_column :contacts, :middle_name
    remove_column :contacts, :first_name
    remove_column :contacts, :birthday
  end

end
