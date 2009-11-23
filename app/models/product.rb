class Product < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :product_type

  validates_presence_of :restaurant, :product_type, :name, :price
  validates_uniqueness_of :code, :scope => :restaurant, :allow_nil => true
  validates_numericality_of :price, :allow_nil => true, :greater_than_or_equal_to => 0.01
end
