## Calculation for EAPC in rate
## Take age-standardized SEV rate in childhood sexual abuse as an example

# Create an empty data frame for data entry 
ASR_2019 <- subset(data, data$year == 2019)
location_name <- ASR_2019$location
EAPC_cal <- data.frame(location = location_name, 
                       EAPC = rep(0, times = 27),
                       UCI = rep(0, times = 27),
                       LCI = rep(0, times = 27))

# A for loop for respectively calculating the EAPC value, upper and lower bounds of certainty interval in each selected locations
for (i in 1:27) {
  location_cal <- as.character(EAPC_cal[i,1])
  a <- subset(data, data$location == location_cal)
  a$y <- log(a$val)
  mod_simp_reg <- lm(y ~ year, data = a)
  estimate <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1])-1)*100
  low <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1]-1.96*summary(mod_simp_reg)[["coefficients"]][2,2])-1)*100
  high <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1]+1.96*summary(mod_simp_reg)[["coefficients"]][2,2])-1)*100
  EAPC_cal[i,2] <- estimate
  EAPC_cal[i,3] <- high
  EAPC_cal[i,4] <- low
}