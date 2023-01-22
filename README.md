# README

-   run tests with `rake spec`
-   using [nix] here to ensure reproducibility for this project, please refer [shell.nix](/shell.nix) to see dependencies

[nix]: https://nixos.org/download.html

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
