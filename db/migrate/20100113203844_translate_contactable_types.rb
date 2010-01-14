class TranslateContactableTypes < ActiveRecord::Migration
  def self.up
    [:email_type, :website_type, :phone_type, :instant_messenger_type, :address_type].each do |clazz|
      Kernel.const_get(clazz.to_s.camelcase).all.each{|post| post.update_attribute(:name, post.read_attribute(:name)) }
      remove_column clazz.to_s.pluralize, :name
    end
  end
  
  def self.down
    [:email_type, :website_type, :phone_type, :instant_messenger_type, :address_type].each do |clazz|
      add_column clazz.to_s.pluralize, :name, :string
      Kernel.const_get(clazz.to_s.camelcase).all.each{|o| o.write_attribute(:name, o.send(:name)); o.save}
    end
  end
end
