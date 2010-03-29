class Table < ActiveRecord::Base
  belongs_to :restaurant

  validates_presence_of :restaurant, :max_party
  validates_numericality_of :max_party
end
