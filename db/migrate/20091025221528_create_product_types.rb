class CreateProductTypes < ActiveRecord::Migration
  def self.up
    create_table :product_types do |t|
      t.references :restaurant, :foreign_key => {:dependent => :destroy}
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :product_types
  end
end

