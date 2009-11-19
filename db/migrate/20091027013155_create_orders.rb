class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.references :restaurant, :foreign_key => {:dependent => :destroy}
      t.datetime :generated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
