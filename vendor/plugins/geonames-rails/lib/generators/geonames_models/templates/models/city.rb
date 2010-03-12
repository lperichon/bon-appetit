class City < ActiveRecord::Base
  belongs_to :country
  belongs_to :division

  # Returns an array with all the parents of this city
  #
  # The first position in the array is the +country+ and up to 4 more positions
  # can contain the ADM1, ADM2, ADM3 and ADM4 divisions containing the city
  def containers
    return @containers unless @containers.nil?
    container_codes = []
    codes = code.split('|')
    container_codes << (codes = codes[0..-2]).join('|') while codes.size > 1
    # first is country code
    @containers = [country]
    # second, third can be parent administrative division if not nil
    # NOTE container codes is like: ["ES|58|PO", "ES|58", "ES"] (country is last)
    @containers += Division.find_all_by_code container_codes[0..-2], :order => :level if container_codes.size > 1
    return @containers
  end
end