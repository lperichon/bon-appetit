class PhoneType < ActiveRecord::Base
  translates :name

  validates_presence_of :name
end
