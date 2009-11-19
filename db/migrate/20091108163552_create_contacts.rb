class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.references :restaurant, :null => false, :foreign_key => {:dependent => :destroy}
    end
  end

  def self.down
    drop_table :contacts
  end
end
