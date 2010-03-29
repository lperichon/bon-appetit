class Restaurant < ActiveRecord::Base
  acts_as_subscriber
  has_many :product_types
  has_many :products
  has_many :orders
  has_many :contacts
  has_many :tables
  
  has_and_belongs_to_many :users
  belongs_to :manager, :class_name => 'User'

  validates_presence_of :name, :manager
  validates_presence_of :tax_value, :if => :include_tax?
  validates_numericality_of :tax_value, :greater_than => 0, :less_than => 1, :if => :include_tax?
end
