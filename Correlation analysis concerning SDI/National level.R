## Correlation analysis at GBD national level
## Take age-standardized SEV rate in childhood sexual abuse as an example

# These packages should be installed in advance
library(ggplot2)
library(reshape)
library(ggrepel)

# Data entry and name unification
data <- read.csv("[DIRECTORY]/Correlation analysis concerning SDI/test data2.csv", header = T)

data$location[data$location == "Democratic People's Republic of Korea"] = 'North Korea'
data$location[data$location == 'Russian Federation'] = 'Russia'
data$location[data$location == 'United Kingdom'] = 'UK'
data$location[data$location == "Iran (Islamic Republic of)"] = 'Iran'
data$location[data$location == "Taiwan"] = 'Taiwan (Province of China)'
data$location[data$location == "Republic of Korea"] = 'South Korea'
data$location[data$location == "United Republic of Tanzania"] = 'Tanzania'
data$location[data$location == "Côte d’Ivoire"] = 'Ivory Coast'
data$location[data$location == "Bolivia (Plurinational State of)"] = 'Bolivia'
data$location[data$location == "Venezuela (Bolivarian Republic of)"] = 'Venezuela'
data$location[data$location == "Czechia"] = 'Czech Republic'
data$location[data$location == "Republic of Moldova"] = 'Moldova'
data$location[data$location == "Viet Nam"] = 'Vietnam'
data$location[data$location == "Lao People's Democratic Republic"] = 'Laos'
data$location[data$location == "Syrian Arab Republic"] = 'Syria'
data$location[data$location == "North Macedonia"] = 'Macedonia'
data$location[data$location == "Brunei Darussalam"] = 'Brunei'
data$location[data$location == "Gambia"] = 'The Gambia'
data$location[data$location == "United States of America"] = 'USA'
data$location[data$location == "Micronesia (Federated States of)"] = 'Federated States of Micronesia'
data$location[data$location == "Bahamas"] = 'The Bahamas'
data$location[data$location == "United States Virgin Islands"] = 'Virgin Islands'
data$location[data$location == "Macedonia"] = 'North Macedonia'
data$location[data$location == 'Democratic Republic of the Congo'] = 'DR Congo'
data$location[data$location == 'Congo'] = 'Congo (Brazzaville)'
data$location[data$location == 'Cabo Verde'] = 'Cape Verde'

SDI <- read.csv("[DIRECTORY]/Correlation analysis concerning SDI/IHME_GBD_2019_SDI_1990_2019.csv", header = T)

SDI <- melt(SDI, id = "Location")
SDI$variable <- as.numeric(gsub("\\X", replacement = "", SDI$variable))
names(SDI) <- c("location","year","SDI")
SDI <- SDI[SDI$year == 2019,]

# Create the correlation plot
data <- data[,c(2,7,8)]
ASR_SDI <- merge(data, SDI, by = c("location", "year"))
plot <- ggplot(ASR_SDI, aes(x = SDI, y = val, label = location)) +
  geom_point(aes(color = location)) +
  geom_text_repel(aes(color = location), size = 2, fontface = "bold", max.overlaps = 160) +
  geom_smooth(colour = "black", stat = "smooth", method = "loess", se = FALSE, span = 0.5) +
  scale_x_continuous(breaks = seq(0.1,0.9,0.1)) +
  scale_y_continuous(breaks = seq(0,24,4)) +
  labs(y = "SEV per 100") +
  theme_bw() +
  theme(legend.position = "none")

# Perform the Spearman's test
cor.test(ASR_SDI$val, ASR_SDI$SDI, method = "spearman")