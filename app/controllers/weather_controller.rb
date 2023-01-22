class WeatherController < ApplicationController
  
    def index
    end
    
    def lookup
        @address = Address.new(params[:query])
        render :index
    end 
end
