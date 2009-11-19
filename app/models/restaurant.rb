class Restaurant < ActiveRecord::Base
  has_many :product_types
  has_many :products
  has_many :orders
  has_many :contacts
  has_and_belongs_to_many :users
  belongs_to :manager, :class_name => 'User'

  validates_presence_of :name, :manager
end
