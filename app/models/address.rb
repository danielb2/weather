require 'excon'
require 'redis'
require 'jq'

class Address
    
    @@mapbox_key = ENV['MAPBOX_ACCESS_TOKEN']
    @@owm_key = ENV['OWM_API_KEY']
    # @@redis = Redis.new

    def self.mapbox_key=(key)
         @@mapbox_key = key
    end

    def self.owm_key=(key)
         @@owm_key = key
    end
    
    def initialize(address)
        @address = address.strip.gsub(' ', '+') # dont need spaces in our address
        @jq = geocode
    end
    
    def set_cache()
    end
    
    def get_cache()
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

    def country_code
        jq = geocode
        return jq.search('[.features[].context[] | select(.id | match("country"))][0].short_code').first
    end
    
    # zip formatted for openweathermap zip,country_code
    def openweathermap_zip
        "#{zipcode.gsub(' ', '')},#{country_code}"
    end
    
    # can make the units depending on country here but for this exercise this is fine
    def current_weather
        response = Excon.get "https://api.openweathermap.org/data/2.5/weather", query: { zip: openweathermap_zip, units: :imperial,
            appid: @@owm_key }
        
        return Weather.new(JSON.parse(response.body))
    end
    
    def forecast
        response = Excon.get "https://api.openweathermap.org/data/2.5/forecast", query: { zip: openweathermap_zip, units: :imperial,
            appid: @@owm_key }
        
        return JSON.parse(response.body)['list'].map do |weather|
            Weather.new(weather)
        end
    end
end

class Address::Weather
    def initialize(data)
        @data = data
    end

    def date
        Time.at(@data['dt'])
    end
    
    def nice_date
        date.strftime("%F %H:%M")
    end

    def temp
        @data['main']['temp']
    rescue Exception
        nil
    end
    
    def temp_max
        @data['main']['temp_max']
    rescue Exception
        nil
    end
    def temp_min
        @data['main']['temp_min']
    rescue Exception
        nil
    end
end

