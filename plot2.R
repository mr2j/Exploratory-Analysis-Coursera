# QUESTION 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# ANSWER: YES, EMISSIONS HAVE DECREASED FROM 1999 (HIGHEST) TO 2008 (LOWEST), HOWEVER 2005 SAW HIGHER EMISSIONS THAN 2002.

# LOAD LIBRARY
library(dplyr)

# LOAD DATA
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# SUMMARIZE PM 2.5 EMISSIONS BY YEAR FOR GIVEN CITY
baltimore <- subset(pm25, fips=="24510")

baltimore <- baltimore %>%
  group_by(year) %>%
  summarize(sum = sum(Emissions, na.rm = T))

# CREATE PNG GRAPHICS DEVICE
png("plot2.png", width = 600, height = 400)

# PLOT DATA
barplot(t(as.matrix(baltimore$sum)), beside=TRUE, names.arg = baltimore$year, col="red", main = "Total Yearly PM2.5 Emissions Baltimore City")

# TURN OFF GRAPHICS DEVICE
dev.off()
