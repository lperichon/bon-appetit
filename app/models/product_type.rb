class ProductType < ActiveRecord::Base
  belongs_to :restaurant
  has_many :products

  validates_presence_of :restaurant
  validates_presence_of :name
end
