require 'address'
Address.mapbox_key=ENV['MAPBOX_ACCESS_TOKEN'] || Rails.application.credentials.mapbox_access_token
Address.owm_key= ENV['OWM_API_KEY'] || Rails.application.credentials.owm_api_key
