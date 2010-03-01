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

  # sqlite3 specific move this to environments or find out what happened to Searchlogic's modifiers
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
    Gregory Brown
    200 Wonderful Drive
    New Haven, CT 06511
    EOS

    recipient = <<-EOS
    Cool Inc.
    100 Awesome Street
    West Foo, VT 01102
    EOS

    invoice = Invoice.new(:sender    => sender,
                          :recipient => recipient,
                          :period    => "2008.08.01 - 2008.08.31",
                          :due       => "September 30th, 2008")

    invoice.entry "Work on something awesome",  :hours => 10.5, :rate => 75.0
    invoice.entry "Work on something terrible", :hours => 5.0,  :rate => 125.0
    invoice.entry "Work on free software",      :hours => 20.0, :rate => 25.0
    invoice.entry "Work for non-profit org",    :hours => 30.0, :rate => 45.0

    filename = "invoice-#{self.id}.pdf"
    file = invoice.save_as "tmp/#{filename}"

    self.invoice = File.new(RAILS_ROOT+"/tmp/#{filename}")
    self.save

    # paperclip creates a copy of the attached file, delete the original
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
    # freeze address
    address_attributes = self.address.attributes
    address_attributes.delete('id')
    address_attributes.delete('owner_id')
    address_attributes.delete('owner_type')
    self.address = Address.create!(address_attributes)

    # freeze order items
    self.order_items.each { |oi| oi.freeze_values; oi.save }

    # freeze total
    self.total = calculate_total

    # freeze contact name
    self.contact_name = self.contact.full_name
  end
end