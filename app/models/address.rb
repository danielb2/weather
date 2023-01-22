require 'excon'
require 'redis'
require 'jq'

class Address
    
    @@mapbox_key = ENV['MAPBOX_ACCESS_TOKEN']
    @@owm_key = ENV['OWM_API_KEY']

    def self.mapbox_key=(key)
         @@mapbox_key = key
    end

    def self.owm_key=(key)
         @@owm_key = key
    end
    
    class Weather
        def initialize
        end
        def date
        end
        def temp
        end
        
        def temp_high
        end
        def temp_low
        end
    end

  @@mapbox_key = ENV['MAPBOX_ACCESS_TOKEN']
  @@openweathermap = ENV['Somethign']
  
    def initialize(address)
        @address = address.strip.gsub(' ', '+') # dont need spaces in our address
        @jq = geocode
    end
    
    def geocode
        return @jq if @jq
        response = Excon.get "https://api.mapbox.com/geocoding/v5/mapbox.places/#{@address}.json",
        query: { access_token: @@mapbox_key }

        @jq = JQ(response.body)
    end
    
  
    def zipcode
        jq = geocode
        return jq.search('[.features[].context[] | select(.id | match("postcode"))][0].text').first
    end
    
    def current_weather
        return Weather.new()
    end
    
    def forecast
        [] # array of Weather
    end
end