require 'address'
Address.mapbox_key=Rails.application.credentials.mapbox_access_token || ENV['MAPBOX_ACCESS_TOKEN']
Address.owm_key=Rails.application.credentials.owm_api_key || ENV['OWM_API_KEY']
