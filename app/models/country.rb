class Country < ActiveRecord::Base
  has_many :cities
  has_many :divisions

  def first_level_divisions
    self.divisions.level_equals(1)
  end
end