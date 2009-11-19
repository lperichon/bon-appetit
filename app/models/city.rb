class City < ActiveRecord::Base
  belongs_to :province
  validates_presence_of :name, :province
end
