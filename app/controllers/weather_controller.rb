class WeatherController < ApplicationController
  
    def index
    end
    
    def lookup
        begin
            @address = Address.new(params[:query])
            @current_weather = @address.current_weather
            @forecast = @address.forecast
            flash.clear
        rescue CityNotFound => e
            @address = nil
            flash[:error] = "City Not Found Error: " + e.message
        rescue WeatherNotFound => e
            flash[:error] = "Weather Not Found Error: " + e.message
        end
        return render :index
    end 
end
