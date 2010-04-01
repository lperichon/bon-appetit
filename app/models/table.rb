class Table < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :type, :class_name => 'TableType'

  validates_presence_of :restaurant, :max_party, :type
  validates_numericality_of :max_party

  has_many :orders

  def after_initialize
    self.top ||= 0
    self.left ||= 0
  end

  def free?
    self.open_orders.empty?
  end

  def occupied?
    !self.free?
  end

  def open_orders
    self.orders.opened
  end

  def status
    self.free? ? :free : :occupied
  end
end
