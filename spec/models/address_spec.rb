require 'rails_helper'

RSpec.describe Address do
  it "allows to get a zip code from address" do
    address = Address.new 'bend,or'
    expect(address.zipcode).to eq('97701')
    address = Address.new 'alingsas'
    expect(address.zipcode).to eq('441 30')
  end

  it "gets the place name of an address" do
    address = Address.new 'bend,or'
    expect(address.place_name).to eq('Bend, Oregon, United States')
  end

  it "allows to get a country code from address" do
    address = Address.new 'bend,or'
    expect(address.country_code).to eq('us')
    address = Address.new 'alingsas'
    expect(address.country_code).to eq('se')
  end

  it "returns openweathermap format for zipcode lookup" do
    address = Address.new 'alingsas'
    expect(address.openweathermap_zip).to eq('44130,se')
  end

  it "returns weather for address" do
    address = Address.new 'bend,or'
    current_weather = address.current_weather
    expect(current_weather.temp).to be_between(0, 130).inclusive
    expect(current_weather.temp_min).to be_between(0, 130).inclusive
    expect(current_weather.temp_max).to be_between(0, 130).inclusive
    expect(current_weather.date).to be_a(Time) 
    expect(current_weather.date.to_i).to be_within(3600*24).of(Time.now.to_i) 
  end

  it "returns forecast weather for address" do
    address = Address.new 'bend,or'
    forecast = address.forecast
    expect(forecast[0].temp).to be_between(0, 130).inclusive
    expect(forecast[0].temp_min).to be_between(0, 130).inclusive
    expect(forecast[0].temp_max).to be_between(0, 130).inclusive
    expect(forecast[0].date).to be_a(Time) 
    expect(forecast[0].date.to_i).to be_within(3600*24).of(Time.now.to_i) 
  end
  
  it "should fail well on a bad address" do
    skip
  end
end
