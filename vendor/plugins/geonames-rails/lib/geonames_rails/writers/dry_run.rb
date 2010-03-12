module GeonamesRails
  module Writers
    class DryRun
      def write_country(country_mapping)
        raise "must have a of country mapping" unless country_mapping
        
        "Dry run of country #{country_mapping[:name]} should have been OK"
      end

      def write_divisions(division_mappings)
        raise "must have a division mapping" unless division_mappings
        raise "there should be at least one division" unless division_mappings.size > 0
        "Dry run of division mappins should have been OK for #{division_mappings.size} divisions"
      end
      
      def write_cities(country_code, city_mappings)
        raise "can't create cities without a country" unless country_code
        raise "must have a set of city mappings" unless city_mappings
        
        raise "i'm sure there should be at least 1 city in this country" if city_mappings.empty?
        
        "Dry run of country #{country_code} would have written out #{city_mappings.length} cities"
      end
    end
  end
end