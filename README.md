# README

-   You'll need to `brew install oniguruma` on a mac. Search for how to install it in the FAQ here: https://github.com/stedolan/jq/wiki/FAQ#installation or use [nix].
-   run tests with `rake spec`
-   using [nix] here to ensure reproducibility for this project, please refer [shell.nix](/shell.nix) to see dependencies
-   requires key set for [mapbox] api using `rails credentials:edit` and openweathermap api key <br>
    ```
    mapbox_access_token: <token>
    owm_api_key: <token>
    ```
    or set using ENV['MAPBOX_ACCESS_TOKEN']
    NOTE: I went with [mapbox] because their geocoding was more lenient with giving a zipcode without needing to specify a street as part of the address
-   the requirement to look up by address and then cache by zipcode is peculiar. basically it means I need to use geocoding to first get the zipcode which then requires more specific address than the weather API needs. It was also more precise than googles API, for example, with my own address which google actually got wrong.
    -   it would make sense to also cache the address so the geocoding api doesn't need to be called each time
-   i can use something like VCR to test the external calls to API but I think that's beyond the scope for this assignment

[nix]: https://nixos.org/download.html
[mapbox]: https://www.mapbox.com/

Things you may want to cover:

-   Ruby version

-   System dependencies

-   Configuration

-   Database creation

-   Database initialization

-   How to run the test suite

-   Services (job queues, cache servers, search engines, etc.)

-   Deployment instructions

# Coding Assignment

Requirements:

-   [x] Must be done in Ruby on Rails
-   [ ] Accept an address as input
-   [ ] Retrieve forecast data for the given address. This should include, at minimum, the
        current temperature (Bonus points - Retrieve high/low and/or extended forecast)
-   [ ] Display the requested forecast details to the user
-   [ ] Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
    -   [ ] Display indicator if result is pulled from cache.

Assumptions:

-   This project is open to interpretation
-   Functionality is a priority over form
-   If you get stuck, complete as much as you can

Submission:

-   Use a public source code repository (GitHub, etc) to store your code
-   Send us the link to your completed code
