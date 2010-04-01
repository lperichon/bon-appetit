class TableType < ActiveRecord::Base
  translates :name
  validates_presence_of :symbol, :name
  validates_uniqueness_of :symbol
end