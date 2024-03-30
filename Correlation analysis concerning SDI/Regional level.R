## Correlation analysis at GBD regional level
## Take age-standardized SEV rate in childhood sexual abuse as an example

# These packages should be installed in advance
library(ggplot2)
library(reshape)
library(ggrepel)

# Data entry
data <- read.csv("[DIRECTORY]/Correlation analysis concerning SDI/test data1.csv", header = T)
SDI <- read.csv("[DIRECTORY]/Correlation analysis concerning SDI/IHME_GBD_2019_SDI_1990_2019.csv", header = T)
order_SDI <- read.csv("[DIRECTORY]/Correlation analysis concerning SDI/order_SDI.csv", header = F)

SDI <- melt(SDI, id = "Location")
SDI$variable <- as.numeric(gsub("\\X", replacement = "", SDI$variable))
names(SDI) <- c("location","year","SDI")
SDI[which(SDI$location == "Central sub-Saharan Africa"),1] <- "Central Sub-Saharan Africa"
SDI[which(SDI$location == "Eastern sub-Saharan Africa"),1] <- "Eastern Sub-Saharan Africa"
SDI[which(SDI$location == "Southern sub-Saharan Africa"),1] <- "Southern Sub-Saharan Africa"
SDI[which(SDI$location == "Western sub-Saharan Africa"),1] <- "Western Sub-Saharan Africa"

# Create the correlation plot
data <- data[,c(2,7,8)]
ASR_SDI <- merge(data, SDI, by = c("location", "year"))
ASR_SDI$location <- factor(ASR_SDI$location, levels = order_SDI$V1, ordered = TRUE)
plot <- ggplot(ASR_SDI, aes(x = SDI, y = val)) +
  geom_smooth(colour = "black", stat = "smooth", method = "loess", se = FALSE, span = 0.5) +
  geom_point(aes(color = location, shape = location, size = year), alpha = 0.7) +
  scale_color_manual(values = c("#dfbf20","#ec8379","#e5594d","#df3020","#b3261a","#59130d","#b3801a","#df9f20","#dfbf20","#cfdf20","#bfdf20","#80b31a","#568613","#2d590d","#138660","#13867c","#1ab3b3","#20bfdf","#2070df","#1a33b3","#5020df","#8c4de5")) +
  scale_shape_manual(values = c(19,21,22,5,2,6,21,22,5,2,6,21,22,5,2,6,21,22,5,2,6,21,22,5,2,6,21,22,5,2,6,21)) +
  scale_size_continuous(breaks = c(1990,1995,2000,2005,2010,2015,2019), range = c(4,0.5)) +
  scale_x_continuous(breaks = seq(0.1,0.9,0.1)) +
  scale_y_continuous(breaks = seq(0,20,2)) +
  labs(y = "SEV per 100", color = guide_legend(title = "GBD region"), shape = guide_legend(title = "GBD region"), size = guide_legend(title = "Year")) +
  theme_bw()

# Perform the Spearman's test
cor.test(ASR_SDI$val, ASR_SDI$SDI, method = "spearman")