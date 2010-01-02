class Order < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :contact
  has_many :order_items

  accepts_nested_attributes_for :order_items

  validates_presence_of :restaurant, :generated_at
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1
  validates_numericality_of :table_id, :greater_than => 0, :allow_blank => true

  default_scope :order => 'generated_at DESC'

  named_scope :opened, :conditions  => {:closed => false}
  named_scope :this_month, :conditions => ["generated_at >= ?", Date.today.beginning_of_month]

  # sqlite3 specific move this to environments or find out what happened to Searchlogic's modifiers
  named_scope :by_dow, proc {|dow| {:conditions => ["strftime('%w', generated_at) = '?'", dow]} }
  named_scope :by_hour, proc {|h| {:conditions => ["strftime('%H', generated_at) = ?", "%02d" % h]} }

  def after_initialize
    self.generated_at ||= DateTime.now
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

  def open?
    !self.closed?
  end

  protected

  def calculate_subtotal
    subtotal = self.order_items.collect {|oi| oi.subtotal}.sum
    subtotal - self.discount*subtotal
  end

  def calculate_total
    self.calculate_subtotal + self.calculate_tax
  end

  def calculate_tax
    self.restaurant.include_tax? ? self.restaurant.tax_value*self.calculate_subtotal : 0
  end

  def freeze_values
    self.order_items.each { |oi| oi.freeze_values; oi.save }
    self.total = calculate_total
  end
end