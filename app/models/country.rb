class Country < ActiveRecord::Base
  has_many :provinces
  validates_presence_of :name
end
