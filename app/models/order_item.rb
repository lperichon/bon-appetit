class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates_presence_of :order
  validates_presence_of :product
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1

  def before_validation
    self.quantity ||= 1
    self.discount ||= 0
  end

  def subtotal
    unless self.order.closed? || !self[:subtotal].nil?
      calculated = self.quantity*self.product.price
      self.update_attribute(:subtotal, calculated - self.discount*calculated)
    end
    return self[:subtotal]
  end
end