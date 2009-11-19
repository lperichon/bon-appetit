class Order < ActiveRecord::Base
  belongs_to :restaurant
  has_many :order_items

  validates_presence_of :restaurant
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1

  def before_validation
    self.discount ||= 0 
  end

  def total
    unless self.closed? || !self[:total].nil?
      subtotal = order_items.collect {|oi| oi.subtotal}.sum
      self.update_attribute(:total, subtotal - self.discount*subtotal)
    end
    return self[:total]
  end

  def to_s
    "Order ##{id.to_s}"
  end
end