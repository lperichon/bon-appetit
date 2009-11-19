class AddActiveToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :active, :default => false, :null => false
      t.change :crypted_password, :string, :null => true
      t.change :password_salt, :string, :null => true
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :active
      t.change :crypted_password, :string, :null => false
      t.change :password_salt, :string, :null => false
    end
  end
end
