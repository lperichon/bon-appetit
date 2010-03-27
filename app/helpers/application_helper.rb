# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Given a number returns :odd or :even
  def odd_or_even(number)
    (number % 2)==1 ? :odd : :even
  end

  DISCOUNTS = {0.0 => 'No Discount', 0.5 => '50%', 1.0 => 'Free'}

  def discount_label(discount)
    DISCOUNTS[discount.to_f]
  end

  # Array of discount options for selects
  def discounts()
    DISCOUNTS.collect {|key, value| [value, key]}
  end

  # RJS conditional helpers
  def rjs_if_element_exists(e)
    page << "if($('##{e}').length){"
  end

  def rjs_unless_element_exists(e)
    page << "if(!$('##{e}').length){"
  end

  def rjs_elsif(e)
    page << "}else if($('#{e}').length){"
  end

  def rjs_else
    page << "}else{"
  end

  def rjs_end
    page << "}"
  end

  def show_messages(flash)
    output = ""
    flash.each do |type, message|
      output << "$.jGrowl('#{message}');"
    end
    flash.discard
    output
  end

  def refresh_map(addresses)
    out = ""
    out << 'map.clearOverlays();'
    addresses.each do |address|
      if address.mapped?
        lat = address.lat
        lng = address.lng
        info = map_address_info(address)
        out << "var marker = addInfoWindowToMarker(new GMarker(new GLatLng(#{lat}, #{lng})), '#{info}', {});"
        out << "map.addOverlay(marker);"
      end
    end
    out
  end

  def map_address_info(address)
    "#{address.type.try(:name)}<br/>#{address.full_address}"
  end
end
