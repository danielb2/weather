- [README](#readme)
- [Coding Assignment](#coding-assignment)
- [Examples](#examples)
  - [Just a city name](#just-a-city-name)
  - [Specific address](#specific-address)
  - [works worldwide](#works-worldwide)

# README

-   You'll need to `brew install oniguruma` on a mac. Search for how to install it in the FAQ here: https://github.com/stedolan/jq/wiki/FAQ#installation or use [nix].
-   You need to run redis as I'm using that for cache/expiration
-   run tests with `rake spec`
-   using [nix] here to ensure reproducibility for this project, please refer [shell.nix](/shell.nix) to see dependencies
-   requires key set for [mapbox] api using `rails credentials:edit` and openweathermap api key <br>
    ```
    mapbox_access_token: <token>
    owm_api_key: <token>
    ```
    or set using env 'MAPBOX_ACCESS_TOKEN' and OWM_API_KEY
    NOTE: I went with [mapbox] because their geocoding was more lenient with giving a zipcode without needing to specify a street as part of the address. Also, openweathermap's geocode doesn't return zipcode
-   the requirement to look up by address and then cache by zipcode is peculiar. basically it means I need to use geocoding to first get the zipcode which then requires more specific address than the weather API needs. It was also more precise than googles API, for example, with my own address which google actually got wrong.
    -   it would make sense to also cache the address so the geocoding api doesn't need to be called each time
-   i can use something like VCR to test the external calls to API but I think that's beyond the scope for this assignment
-   no idea how long I spent on this. I did it over the weekend with a lot of interrupts. And I also really enjoyed it.
-   some more testing could be done, on the request endpoints, but I think this is good enough for this exercise
-   it's unclear why I can pull London's weather data using the API call using just a query, but I can't do it using the zip API call
-   I'm not implementing user ability to choose units (metric/imperial) but it's something that would be useful
-   sometimes a city and weather could be found, but there's no zipccode, so the city just isn't displayed. for example, saigon weather could be shown with a different API. I decided to skip that functionality since the requirements was to cache on zip, and I think it's beyond the scope. I want to mention this detail for your reflection

[nix]: https://nixos.org/download.html
[mapbox]: https://www.mapbox.com/

# Coding Assignment

Requirements:

-   [x] Must be done in Ruby on Rails
-   [x] Accept an address as input
-   [x] Retrieve forecast data for the given address. This should include, at minimum, the
        current temperature (Bonus points - Retrieve high/low and/or extended forecast)
-   [x] Display the requested forecast details to the user
-   [x] Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
    -   [x] Display indicator if result is pulled from cache.

Assumptions:

-   This project is open to interpretation
-   Functionality is a priority over form
-   If you get stuck, complete as much as you can

Submission:

-   Use a public source code repository (GitHub, etc) to store your code
-   Send us the link to your completed code

# Examples

## Just a city name

![tempe](./images/../screenshots/tempe.png)

## Specific address

![specific](./images/../screenshots/specific_address.png)

## works worldwide

![specific](./images/../screenshots/stockholm.png)
