class Order < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :contact
  belongs_to :address
  has_many :order_items
  has_attached_file :invoice

  accepts_nested_attributes_for :order_items

  validates_presence_of :restaurant, :generated_at
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1
  validates_numericality_of :table_id, :greater_than => 0, :allow_blank => true

  default_scope :order => 'generated_at DESC'

  named_scope :opened, :conditions  => {:closed => false}
  named_scope :this_month, :conditions => ["generated_at >= ?", Time.zone.today.beginning_of_month]
  named_scope :between, proc {|s, e| {:conditions => ["generated_at BETWEEN ? AND ?", s, e]}}

  #TODO: sqlite3 specific move this to environments or find out what happened to Searchlogic's modifiers
  named_scope :by_dom, proc {|dom| {:conditions => ["strftime('%d', generated_at) = ?", "%02d" % dom]} }
  named_scope :by_dow, proc {|dow| {:conditions => ["strftime('%w', generated_at) = '?'", dow]} }
  named_scope :by_hour, proc {|h| {:conditions => ["strftime('%H', generated_at) = ?", "%02d" % h]} }

  def after_initialize
    self.generated_at ||= Time.zone.now
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

  def create_invoice
    sender = <<-EOS
    #{self.restaurant.name}
    EOS

    recipient = <<-EOS
    #{self.contact_name if self.contact_name.present?}
    #{self.address.full_address if self.address.present?}
    table:#{self.table_id}
    EOS

    invoice = Invoice.new(:sender    => sender, :recipient => recipient, :subtotal => self.subtotal, :taxes => self.calculate_tax(self.subtotal), :discount => self.discount, :total => self.total)

    self.order_items.each do |oi|
      invoice.entry oi.product_name, oi.quantity, oi.unit_price, oi.discount, oi.subtotal
    end

    filename = "invoice-#{self.id}.pdf"
    file = invoice.save_as "tmp/#{filename}"

    self.invoice = File.new(RAILS_ROOT+"/tmp/#{filename}")
    self.save

    # TODO: paperclip creates a copy of the attached file, delete the original
  end

  protected

  def calculate_subtotal
    self.order_items.collect {|oi| oi.subtotal}.sum
  end

  def calculate_total
    subtotal = self.calculate_subtotal
    subtotal - self.discount*subtotal + self.calculate_tax(subtotal)
  end

  def calculate_tax(subtotal)
    self.restaurant.include_tax? ? self.restaurant.tax_value*subtotal : 0
  end

  def freeze_values
    # freeze address
    if self.address.present?
      address_attributes = self.address.attributes
      address_attributes.delete('id')
      address_attributes.delete('owner_id')
      address_attributes.delete('owner_type')
      self.address = Address.create!(address_attributes)
    end

    # freeze order items
    self.order_items.each { |oi| oi.freeze_values; oi.save }

    # freeze total
    self.subtotal = calculate_subtotal
    self.total = calculate_total

    # freeze contact name
    self.contact_name = self.contact.name if self.contact.present?
  end
end