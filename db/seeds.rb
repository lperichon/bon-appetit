# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Create admin user
admin_user = User.create(:username => 'luigi', :email => 'luigi@admin.com', :password => 'password', :password_confirmation => 'password')
admin_user.admin = true
admin_user.active = true
admin_user.save

# Create contactable types
I18n.locale = :en
EmailType.create!(:name => 'Home')
PhoneType.create!(:name => 'Home')
WebsiteType.create!(:name => 'Home')
AddressType.create!(:name => 'Home')
InstantMessengerType.create!(:name => 'Home')
EmailType.create!(:name => 'Work')
PhoneType.create!(:name => 'Work')
WebsiteType.create!(:name => 'Work')
AddressType.create!(:name => 'Work')
InstantMessengerType.create!(:name => 'Work')
EmailType.create!(:name => 'Other')
PhoneType.create!(:name => 'Other')
WebsiteType.create!(:name => 'Other')
AddressType.create!(:name => 'Other')
InstantMessengerType.create!(:name => 'Other')
InstantMessengerProtocol.create!(:name => 'MSN')

# Create locations
arg = Country.create!(:name => 'Argentina')
bsas = arg.provinces.create!(:name => 'Buenos Aires')
bsas.cities.create!(:name => 'San Isidro') 