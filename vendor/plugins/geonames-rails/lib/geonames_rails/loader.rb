module GeonamesRails
  
  class Loader

    CITY_EXCLUDES = %w{PPLX PPLL PPLQ} # city sections, localities or abandoned places
    
    def initialize(puller, writer, logger = nil)
      @logger = logger || STDOUT
      @puller = puller
      @writer = writer
    end
    
    def load_data
      @puller.pull if @puller # pull geonames files down
      
      load_countries
      load_divisions
      load_cities
      
      @puller.cleanup if @puller # cleanup the geonames files
    end
    
  protected
    def load_countries
      log_message "opening countries file"
      mappings = []
      File.open(File.join(RAILS_ROOT, 'tmp', 'countryInfo.txt'), 'r') do |f|
        f.each_line do |line|
          # skip comments
          next if line.match(/^#/) || line.match(/^iso/i)
          # test only AR
          next unless line.match(/^AR/)
          
          mappings << Mappings::Country.new(line)

          log_message "Pre-loaded #{mappings.size} countries"
        end
      end
      # Now find alternate names...
#      country_ids = mappings.collect {|country_mapping| country_mapping[:geonames_id]}
#      log_message "opening allCountries file... processign will take some time"
#      File.open(File.join(RAILS_ROOT, 'tmp', 'allCountries.txt'), 'r') do |f|
#        f.each_line do |line|
#          parts = line.split("\t")
#          next if parts.size != 19 # bad records
#          if (idx = country_ids.index parts[0])
#            mappings[idx][:alternate_names] = parts[3]
#            log_message "Settings alternate names for #{mappings[idx][:name]} to #{mappings[idx][:alternate_names]}"
#          end
#        end
#      end

      mappings.each do |country_mapping|
        result = @writer.write_country(country_mapping)
        log_message result
      end
    end

    def load_divisions(filename = 'AR.txt')
      log_message "opening allCountries file... processign will take some time"
      divisions = []
      File.open(File.join(RAILS_ROOT, 'tmp', filename), 'r') do |f|
        f.each_line do |line|
          parts = line.split("\t")
          next if parts.size != 19 # bad records
          next unless parts[6] == 'A' and parts[7] =~ /^ADM[1234]$/ # only admins
          # test: only spain
          # next unless parts[8] == 'ES'
          # end-test
          divisions << Mappings::Division.new(line)
          #break if divisions.size > 500
        end
      end
      result = @writer.write_divisions(divisions)
      log_message result
    end
    
    def load_cities(filename = 'AR')
#      %w(allCountries).each do |city_file|
        load_cities_file(filename)
#      end
    end
    
    def load_cities_file(city_file)
      log_message "Loading city file #{city_file}"
      cities = []
      count = 0;
      File.open(File.join(RAILS_ROOT, 'tmp', "#{city_file}.txt"), 'r') do |f|
        f.each_line do |line|
          parts = line.split("\t")
          if parts.size != 19 # bad records
            #log_message "Bad records!"
            next
          end
          unless parts[6] == 'P' && !CITY_EXCLUDES.include?(parts[7])
            #log_message "Not a 'P'"
            next
          end
          cities << Mappings::City.new(line)
          if (cities.length == 5000)
            count += cities.length
            write_city_chunk(cities)
            cities = []
          end
        end
      end
      write_city_chunk(cities)
      log_message "Total cities: #{count + cities.length}"
    end

    def write_city_chunk(cities)
      start = Time.now
      log_message "#{cities.length} cities to process"
      cities_by_country_code = cities.group_by { |city_mapping| city_mapping[:country_iso_code_two_letters] }

      cities_by_country_code.keys.each do |country_code|
        cities = cities_by_country_code[country_code]

        result = @writer.write_cities(country_code, cities)

        log_message result
      end
      log_message "#{cities.length} cities processed in #{Time.now - start} seconds"
    end
    
    def log_message(message)
      @logger << message
      @logger << "\n"
    end
  end
end