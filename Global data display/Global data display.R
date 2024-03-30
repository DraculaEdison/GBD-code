## Mapping for global data display
## Take age-standardized SEV rate in childhood sexual abuse as an example

# These packages should be installed in advance
library(ggplot2)
library(ggmap)
library(rgdal)
library(maps)
library(dplyr)

# data entry
data <- read.csv("[DIRECTORY]/Global data display/test data.csv", header = TRUE)

# Get longitude and latitude of countries
worldData <- map_data("world")

country_asr <- data
country_asr$location <- as.character(country_asr$location)

# The name of certain countries used in GBD study and R packages cam be different.
# Here we unify the names to avoid incomplete data display.
country_asr$location[country_asr$location == "United States of America"] = "USA"
country_asr$location[country_asr$location == "Russian Federation"] = "Russia"
country_asr$location[country_asr$location == "United Kingdom"] = "UK"
country_asr$location[country_asr$location == "Congo"] = "Republic of Congo"
country_asr$location[country_asr$location == "Iran (Islamic Republic of)"] = "Iran"
country_asr$location[country_asr$location == "Democratic People's Republic of Korea"] = "North Korea"
country_asr$location[country_asr$location == "Taiwan (Province of China)"] = "Taiwan"
country_asr$location[country_asr$location == "Republic of Korea"] = "South Korea"
country_asr$location[country_asr$location == "United Republic of Tanzania"] = "Tanzania"
country_asr$location[country_asr$location == "Côte d'Ivoire"] = "Ivory Coast"
country_asr$location[country_asr$location == "Bolivia (Plurinational State of)"] = "Bolivia"
country_asr$location[country_asr$location == "Venezuela (Bolivarian Republic of)"] = "Venezuela"
country_asr$location[country_asr$location == "Czechia"] = "Czech Republic"
country_asr$location[country_asr$location == "Republic of Moldova"] = "Moldova"
country_asr$location[country_asr$location == "Viet Nam"] = "Vietnam"
country_asr$location[country_asr$location == "Lao People's Democratic Republic"] = "Laos"
country_asr$location[country_asr$location == "Syrian Arab Republic"] = "Syria"
country_asr$location[country_asr$location == "North Macedonia"] = "Macedonia"

# Combine the two data frames and cut into appropriate intervals
total <- full_join(worldData, country_asr, by = c("region" = "location"))
total <- total %>% mutate(val2 = cut(val,
                                     breaks = c(0,5,7,10,15,30),
                                     labels = c("0 ~ 5","5 ~ 7","7 ~ 10","10 ~ 15","15 +"),
                                     include.lowest = T,
                                     right = T))

# Create the map plot
plot <- ggplot() +
  geom_polygon(data = total,
               aes(x = long, y = lat, group = group, fill = val2),
               colour = "white",
               linewidth = 0.1) +
  scale_fill_manual(values = c("#fdedce","#fbdc9d","#f7b83b","#c48508","#936406"), na.value = "white") +
  theme_void() +
  labs(x = "", y = "") +
  guides(fill = guide_legend(title = "SEV")) +
  theme(legend.position = "right") +
  theme(legend.title = element_text(size = 9),
        legend.text = element_text(size = 7),
        legend.key.size = unit(0.5, "cm"))