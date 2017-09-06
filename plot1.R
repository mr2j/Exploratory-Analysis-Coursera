# QUESTION 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Answer: YES, EMISSIONS HAVE DECREASED OVERALL, SEE PLOT.

# LOAD LIBRARY
library(dplyr)

# LOAD DATA
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# SUMMARIZE PM 25 EMISSIONS BY YEAR
data <- pm25 %>%
  group_by(year) %>%
  summarize(sum = sum(Emissions, na.rm = T))

# CREATE PNG GRAPHICS DEVICE
png("plot1.png", width = 600, height = 400)

# PLOT DATA
barplot(t(as.matrix(data$sum)),beside=TRUE, names.arg = data$year, col="blue", main = "Total Yearly PM2.5 Emissions")

# TURN OFF GRAPHICS DEVICE
dev.off()
