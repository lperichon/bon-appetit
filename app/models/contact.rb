class Contact < ActiveRecord::Base
  contactable
  belongs_to :restaurant
end
