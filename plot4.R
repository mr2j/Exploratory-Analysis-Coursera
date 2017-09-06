# QUESTION 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008? 
# ANSWER: THE EMISSIONS HAVE DECREASED 1999 - 2008. NOTE TINY INCREASE 2002 - 2005.

# LOAD LIBRARY
library(ggplot2)

# LOAD DATA
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# SUMMARIZE PM 2.5 EMISSIONS BY YEAR AND FOR COAL + COMBUSTION SOURCES
select <- grep("comb(.*)coal|coal(.*)comb",scc$EI.Sector,ignore.case = TRUE)
scc_sub <- scc[select,]$SCC
data <- pm25[pm25$SCC %in% scc_sub,]
data$year <- as.factor(data$year)

data <- data %>%
  group_by(year) %>%
  summarize(sum = sum(Emissions))

# CREATE PNG GRAPHICS DEVICE
png("plot4.png", width = 600, height = 400)

# PLOT DATA
g <- ggplot(data, aes(year,sum))
g + geom_point(aes(color="red"), size=5) + 
  theme(legend.position='none') + 
  labs(title="Yearly PM25 Emissions For Combustion & Coal Related Sources") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylim(0, 600000)

# TURN OFF GRAPHICS DEVICE
dev.off()
