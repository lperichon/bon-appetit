class Address < ActiveRecord::Base

  belongs_to :owner, :polymorphic => true
  belongs_to :type, :class_name => 'AddressType'
  belongs_to :city
  belongs_to :country
  belongs_to :division1, :class_name => 'Division'
  belongs_to :division2, :class_name => 'Division'
  belongs_to :division3, :class_name => 'Division'
  belongs_to :division4, :class_name => 'Division'

  acts_as_mappable :default_units => :kms
  before_save :cleanup_address
  before_validation :geocode_address

  def full_address
    returning address_str = "" do
      if self.address.present?
        address_str << self.address
      end
      if self.city.present?
        address_str << ", #{self.city.name}"
      end
      if self.zip.present?
        address_str << " (#{self.zip})"
      end
      %w(division4 division3 division2 division1).each do |division|
        if self.send(division).present?
          address_str << ", #{self.send(division).name}"
        end
      end
      if self.country.present?
        address_str << ", #{self.country.name}"
      end
    end
  end

  def mapped?
    lat && lng
  end

  def coordinates
    [lat, lng]
  end

  def cities
    if self.division4
      self.division4.cities
    elsif self.division3 && self.division3.children.empty?
      self.division3.cities
    elsif self.division2 && self.division2.children.empty?
      self.division2.cities
    elsif self.division1 && self.division1.children.empty?
      self.division1.cities
    elsif self.country && self.country.first_level_divisions.empty?
      self.country.cities
    else
      []
    end
  end

  private

  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode(self.full_address)
    errors.add(:address, I18n.t('address.geocode_error')) if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

  def cleanup_address
    (2..4).to_a.reverse.each do |idx|
      # if division[idx-1] is not parent of division[idx]
      # or division[idx] is not present
      # or division[idx-1] is not present
      if(self.send("division#{idx}").present? && self.send("division#{idx - 1}").present? && self.send("division#{idx - 1}") != self.send("division#{idx}").parent ||
          self.send("division#{idx}").blank? ||
          self.send("division#{idx - 1}").blank?)
        (idx..4).each do |invalid_idx|
          # cleanup all divisions below
          self.send("division#{invalid_idx}=", nil)
        end
      end

      if(self.division1.present? && self.country.present? && self.country != self.division1.country ||
          self.country.blank?)
        (1..4).each do |invalid_idx|
          # cleanup all divisions below
          self.send("division#{invalid_idx}=", nil)
        end
      end

      self.city = nil unless self.cities.include?(self.city)
    end
  end
end
