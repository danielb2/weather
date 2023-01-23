module WeatherHelper
  
    def header(address)
        heading = address.place_name
        
        if address.cached?
            heading += " [cached]"
        end
        return content_tag(:h2,heading).html_safe
    end

    def rows_for_weather(entries)
        entries.map do |entry|
            content_tag :tr do
                content_tag(:td, entry.nice_date) +
                content_tag(:td, entry.temp) +
                content_tag(:td, entry.temp_max) +
                content_tag(:td, entry.temp_min)
            end
        end.join.html_safe
    end
end
