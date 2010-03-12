class UseGeonamesModelsOnAddress < ActiveRecord::Migration
  def self.up
    remove_column :addresses, :province_id
    add_column :addresses, :division1_id, :integer
    add_column :addresses, :division2_id, :integer
    add_column :addresses, :division3_id, :integer
    add_column :addresses, :division4_id, :integer
  end

  def self.down
    add_column :addresses, :province_id, :integer
    remove_column :addresses, :division1_id
    remove_column :addresses, :division2_id
    remove_column :addresses, :division3_id
    remove_column :addresses, :division4_id
  end
end
