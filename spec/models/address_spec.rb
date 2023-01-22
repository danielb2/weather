require 'rails_helper'

RSpec.describe Address do
  it "allows to get a zip code from address" do
    address = Address.new 'bend,or'
    expect(address.zipcode).to eq('97701')
  end
end
