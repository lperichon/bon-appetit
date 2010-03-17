class CreateContactableIdentifications < ActiveRecord::Migration
  def self.up
    create_table  :identifications do |t|
      t.integer   :owner_id
      t.string    :owner_type
      t.integer   :type_id
      t.string    :code

      t.timestamps
    end

    create_table  :identification_types do |t|
      t.string    :name
    end
  end

  def self.down
    drop_table :identifications
    drop_table :identification_types
  end
end
