# QUESTION 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
# ANSWER: THEY HAVE DECREASED ON AVERAGE, WITH A SPIKE 2005

# LOAD LIBRARY
library(ggplot2)

# LOAD DATA
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# SUMMARIZE PM 2.5 EMISSIONS FOR VEHICLES IN BALTIMORE CITY
rows <- grep("vehicle", scc$EI.Sector, ignore.case = TRUE)
scc_sub <- scc[rows,]$SCC

data <- pm25[pm25$SCC %in% scc_sub,]
data <- subset(pm25, fips=="24510")
data$year <- as.factor(data$year)

data <- data %>%
  group_by(year) %>%
  summarize(sum = sum(Emissions))

# CREATE PNG GRAPHICS DEVICE
png("plot5.png", width = 600, height = 400)

# PLOT DATA
g <- ggplot(data, aes(year,sum))
g + geom_point(aes(color="green"), size=5) + 
  theme(legend.position='none') + 
  labs(title="Yearly PM2.5 Emissions For Vehicles In Baltimore City") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylim(0, 4000)
  

# TURN OFF GRAPHICS DEVICE
dev.off()
