class CreateTableTypes < ActiveRecord::Migration
  def self.up
    create_table :table_types do |t|
      t.string 'symbol'
      t.timestamps
    end
    create_table :table_type_translations do |t|
      t.string   "locale"
      t.integer  "table_type_id"
      t.string   "name"

      t.timestamps
    end
    add_column :tables, :type_id, :integer
  end

  def self.down
    remove_column :tables, :type_id
    drop_table :table_type_translations
    drop_table :table_types
  end
end
