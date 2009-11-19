class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.references :restaurant, :foreign_key => {:dependent => :destroy}
      t.references :product_type, :foreign_key => {:dependent => :destroy}
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
