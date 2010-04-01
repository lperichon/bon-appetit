class Table < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :type, :class_name => 'TableType'

  validates_presence_of :restaurant, :max_party, :type
  validates_numericality_of :max_party

  def after_initialize
    self.top ||= 0
    self.left ||= 0
  end
end
