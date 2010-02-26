class Address < ActiveRecord::Base

  belongs_to :owner, :polymorphic => true
  belongs_to :type, :class_name => 'AddressType'
  belongs_to :city
  belongs_to :country
  belongs_to :province

  acts_as_mappable :default_units => :kms
  before_validation :geocode_address

  def city_name
    city.name if city
  end

  def city_name=(name)
    self.city = City.find_or_create_by_name(name.to_s.titleize) unless name.blank?
  end

  def province_name
    province.name if province
  end

  def province_name=(name)
    self.province = Province.find_or_create_by_name(name.to_s.titleize) unless name.blank?
  end

  def country_name
    country.name if country
  end

  def country_name=(name)
    self.country = Country.find_or_create_by_name(name.to_s.titleize) unless name.blank?
  end

  def full_address
    "#{self.address}, #{self.city.name} (#{self.zip}), #{self.province.name}, #{self.country.name}"
  end

  def mapped?
    lat && lng
  end

  def coordinates
    [lat, lng]
  end

  private

  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode(self.full_address)
    errors.add(:address, t('address.geocode_error')) if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
end
