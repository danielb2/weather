require 'rails_helper'

RSpec.describe Address do
  it "allows to get a zip code from address" do
    address = Address.new 'bend,or'
    expect(address.zipcode).to eq('97701')
    address = Address.new 'alingsas'
    expect(address.zipcode).to eq('441 30')
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
    skip 'not done yet'
    address = Address.new 'alingsas'
    current_weather = address.current_weather
    expect(current_weather.temperature).to eq('23')
    expect(current_weather.temp).to eq('323')
  end
end
