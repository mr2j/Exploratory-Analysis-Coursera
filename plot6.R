# QUESTION 6
# Compare emissions from motor vehicle sources in Baltimore City,
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions? 
# ANSWER: 

# LOAD LIBRARY
library(ggplot2)

# LOAD DATA
pm25 <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# SUMMARIZE PM 2.5 EMISSIONS FOR VEHICLES IN BALTIMORE CITY
rows <- grep("vehicle", scc$EI.Sector, ignore.case = TRUE)
scc_sub <- scc[rows,]$SCC

data <- pm25[pm25$SCC %in% scc_sub,]

sub1 <- subset(data, fips=="24510")
sub1$city <- rep("baltimore",nrow(sub1))
sub1$city <- as.factor(sub1$city)

sub2 <- subset(data, fips=="06037")
sub2$city <- rep("losangeles",nrow(sub2))
sub2$city <- as.factor(sub2$city)

new_df <- rbind(sub1,sub2)

data <- new_df %>%
  group_by(year, city) %>%
  summarize(sum = sum(Emissions))

# CREATE PNG GRAPHICS DEVICE
png("plot5.png", width = 600, height = 400)

# PLOT DATA
g <- ggplot(data, aes(year,sum))
g + geom_point(aes(color=city), size=5) + 
  facet_grid(. ~ city) + 
  theme(legend.position='none') + 
  labs(title="Yearly PM2.5 Emissions For Vehicles In Baltimore VS. Los Angeles") +
  theme(plot.title = element_text(hjust = 0.5)) 

# TURN OFF GRAPHICS DEVICE
dev.off()
