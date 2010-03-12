class Contact < ActiveRecord::Base
  contactable
  belongs_to :restaurant

  named_scope :starts_with, proc {|c| { :conditions => ["first_name LIKE ?", "#{c}%"] } }

  has_many :orders

  def map
    @map ||= prepare_map
  end

  private

  def prepare_map
    return if self.addresses.empty?
    returning GMap.new("gmap") do |map|
      map.control_init(:large_map => true, :map_type => true)
      map_centered = false
      self.addresses.each do |address|
        map.center_zoom_init(address.coordinates, 15) if address.mapped? && !map_centered # Set the center and zoom level
        map_centered = true
        map.overlay_init(GMarker.new(address.coordinates, {:info_window => "#{address.type.try(:name)}<br/>#{address.full_address}"})) if address.mapped?
      end
    end
  end
end
