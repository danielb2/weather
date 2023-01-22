class WeatherController < ApplicationController
    OWM = OpenWeatherMap::API.new(Rails.application.credentials.openweathermap.api_key, 'en', 'imperial')
  
    def index
    end
    
    def lookup
        @something = OWM.current(params[:query]).weather_conditions.temperature
        render :index
    end 
end
