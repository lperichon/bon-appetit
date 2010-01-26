class AddInvoiceColumnsToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :invoice_file_name,    :string
    add_column :orders, :invoice_content_type, :string
    add_column :orders, :invoice_file_size,    :integer
    add_column :orders, :invoice_updated_at,   :datetime
  end

  def self.down
    remove_column :orders, :invoice_file_name
    remove_column :orders, :invoice_content_type
    remove_column :orders, :invoice_file_size
    remove_column :orders, :invoice_updated_at
  end
end
