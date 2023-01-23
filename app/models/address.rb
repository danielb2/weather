require 'excon'
require 'redis'
require 'jq'

class CityNotFound < Exception
end

class WeatherNotFound < Exception
end

class Address
    attr_reader :address, :place_name, :zipcode, :country_code, :openweathermap_zip, :current_weather, :forecast
    
    @@mapbox_key = ENV['MAPBOX_ACCESS_TOKEN']
    @@owm_key = ENV['OWM_API_KEY']
    @@redis = Redis.new

    def self.mapbox_key=(key)
         @@mapbox_key = key
    end

    def self.owm_key=(key)
         @@owm_key = key
    end
    
    def initialize(address)
        @address = address.strip.gsub(' ', '+') # dont need spaces in our address
        self.set_geocode_data_for(@address)
        self.set_weather_data
    end
    
    def cached?
        not @cached.nil?
    end
    
    private
    
    # we can have instance caching, or redis caching. but I'm only going to do
    # redis caching for this case. I'm also aware I'm storing more data than we
    # need to store, and I would clean it up for a real project, but for this
    # demonstration, I think this is sufficient
    
    def set_weather_data

        return nil if @current_weather # we've done the work... don't try
        cached = get_cache(openweathermap_zip)

        data = {}

        if cached
            data = cached
            @cached  = true
        else
            data = {
                "current" => get_current,
                "forecast" => get_forecast
            }
            set_cache(openweathermap_zip, data)
        end
        
        @current_weather = Weather.new(data['current'])
        @forecast = data['forecast'].map { |forecast| Weather.new(forecast) }
        
        return nil # just side effects
    end
    

    def set_cache(key, value)
        @@redis.set(key, value.to_json)
        ap value.to_json
        @@redis.expire(key, 600 * 3) # expires after 30 mins
    end
    
    def get_cache(key)
        JSON.parse(@@redis.get(key) || 'null')
    end
    
    def set_geocode_data_for(address)
        return nil if @place_name

        response = Excon.get "https://api.mapbox.com/geocoding/v5/mapbox.places/#{address}.json",
        query: { access_token: @@mapbox_key }

        jq = JQ(response.body)

        @place_name = jq.search('.features[].place_name').first

        if not @place_name
            raise CityNotFound.new 'No information for this city'
        end

        @zipcode = jq.search('[.features[].context[] | select(.id | match("postcode"))][0].text').first
        @country_code = jq.search('[.features[].context[] | select(.id | match("country"))][0].short_code').first
        # zip formatted for openweathermap zip,country_code
        @openweathermap_zip = "#{@zipcode},#{@country_code}"
        return nil # this is a side_effect function
    end

    def get_current
        
        response = Excon.get "https://api.openweathermap.org/data/2.5/weather", query: { zip: openweathermap_zip, units: :imperial,
            appid: @@owm_key }, debug: true
        
        json = JSON.parse(response.body)

        if response.status != 200
            raise WeatherNotFound.new(json['message'])
        end
        
        return json
    end
    
    def get_forecast
        response = Excon.get "https://api.openweathermap.org/data/2.5/forecast", query: { zip: openweathermap_zip, units: :imperial,
            appid: @@owm_key }
        
        return JSON.parse(response.body)['list']
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

