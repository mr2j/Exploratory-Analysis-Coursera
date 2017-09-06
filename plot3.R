# QUESTION 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?
# ANSWER: TYPES NON-ROAD, NONPOINT AND ON-ROAD HAVE SEEN DECREASES. TYPE POINT HAVE SEEN INCREASES.

# LOAD LIBRARY
library(ggplot2)

# LOAD DATA
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# SUMMARIZE PM 2.5 EMISSIONS BY YEAR AND TYPE FOR GIVEN CITY
baltimore2 <- subset(pm25, fips=="24510")

baltimore2 <- baltimore2 %>%
  group_by(year, type) %>%
  summarize(sum = sum(Emissions, na.rm = T))

baltimore2$type <- as.factor(baltimore2$type)

# CREATE PNG GRAPHICS DEVICE
png("plot3.png", width = 600, height = 400)

# PLOT DATA
g <- ggplot(baltimore2, aes(year,sum))
g + geom_point(aes(color=type), size=3) + 
  facet_grid(. ~ type) + 
  theme(legend.position='none') + 
  labs(title="Yearly PM25 Emissions By Type In Baltimore City") +
  theme(plot.title = element_text(hjust = 0.5))

# TURN OFF GRAPHICS DEVICE
dev.off()
