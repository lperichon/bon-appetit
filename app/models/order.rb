class Order < ActiveRecord::Base
  belongs_to :restaurant
  has_many :order_items

  validates_presence_of :restaurant
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1

  def before_validation
    self.discount ||= 0 
  end

  def before_save
    if self.closed_changed? && closed?
      freeze_values
    end
  end

  def total
    if self.closed?
      self[:total]
    else
      calculate_total
    end
  end

  def to_s
    "Order ##{id.to_s}"
  end

  protected

  def calculate_total
    subtotal = self.order_items.collect {|oi| oi.subtotal}.sum
    total =  subtotal - self.discount*subtotal
    total
  end

  def freeze_values
    self.order_items.each { |oi| oi.freeze_values; oi.save }
    self.total = calculate_total
  end
end