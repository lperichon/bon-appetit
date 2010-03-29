class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :tables do |t|
      t.references :restaurant
      t.integer :max_party

      t.timestamps
    end
  end

  def self.down
    drop_table :tables
  end
end
