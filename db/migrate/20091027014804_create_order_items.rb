class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.references :order, :foreign_key => {:dependent => :destroy}
      t.references :product, :foreign_key => {:dependent => :destroy}
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
