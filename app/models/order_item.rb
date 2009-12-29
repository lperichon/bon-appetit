class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates_presence_of :order
  validates_presence_of :product
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1

  def after_initialize
    self.quantity ||= 1
    self.discount ||= 0
  end

  def subtotal
    if self.order.closed?
      self[:subtotal]
    else
      calculate_subtotal
    end
  end

  def unit_price
    if self.order.closed?
      self[:unit_price]
    else
      self.product.price
    end
  end

  def freeze_values
    self.unit_price = self.product.price
    self.subtotal =  calculate_subtotal
  end

  private

  def calculate_subtotal
    calculated = self.quantity*self.unit_price
    subtotal = calculated - self.discount*calculated
    subtotal
  end
end