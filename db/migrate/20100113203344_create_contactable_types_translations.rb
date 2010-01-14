class CreateContactableTypesTranslations < ActiveRecord::Migration
  def self.up
    [:email_type, :website_type, :phone_type, :instant_messenger_type, :address_type].each do |clazz|
      create_table "#{clazz}_translations" do |t|
        t.string     :locale
        t.references clazz
        t.string     :name
        t.timestamps
      end
    end
  end

  def self.down
    [:email, :website, :phone, :instant_messenger, :address].each do |clazz|
      drop_table "#{clazz}_type_translations"
    end
  end
end
