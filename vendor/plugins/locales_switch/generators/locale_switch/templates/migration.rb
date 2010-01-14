class <%= class_name %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table %>, :<%= LocalesSwitch::LOCALE_IDENTIFIER %>, :string, :limit => 6 # en-BR
  end

  def self.down
    remove_column :<%= table %>, :<%= LocalesSwitch::LOCALE_IDENTIFIER %>
  end
end
