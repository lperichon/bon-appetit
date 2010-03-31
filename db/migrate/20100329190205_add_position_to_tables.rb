class AddPositionToTables < ActiveRecord::Migration
  def self.up
    add_column :tables, :top, :integer
    add_column :tables, :left, :integer
  end

  def self.down
    remove_column :tables, :left
    remove_column :tables, :top
  end
end
