## Explore the National Emissions Inventory database 
## and see what it say about fine particulate matter pollution in the United states 
## over the 10-year period 1999–2008

#6. Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, California(fips == "06037")
# Which city has seen greater changes over time in motor vehicle emissions?
#Ans: Los Angeles county has seen greater changes over time due to its large highs and lows

library(ggplot2)
library(dplyr)

## Read NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_balti_LA <- subset(NEI, fips=="24510" | fips == "06037")

SCC_motor <- SCC %>% filter(grepl('[Vv]ehicle', EI.Sector))

NEI_SCC_motor <- merge(NEI_balti_LA, SCC_motor, by = "SCC")
NEI_SCC_motor_sum <- data.frame(as.table(with(NEI_SCC_motor, tapply(Emissions, list("year"=year, "fips"=fips), sum, na.rm=TRUE, simplify = TRUE))))
colnames(NEI_SCC_motor_sum)[3] <- "Emissions"

NEI_SCC_motor_sum$city[which(NEI_SCC_motor_sum$fips == "24510")] <- "Baltimore City"
NEI_SCC_motor_sum$city[which(NEI_SCC_motor_sum$fips == "06037")] <- "Los Angeles County"

#Open a png file to write the data
png(file = "plot6.png", width = 650, height = 480)

options(scipen=10000)

#Plot a graph for PM2.5 Emissions of motor vehicle sources-Baltimore vs Los Angeles 1999-2008
ggplot(NEI_SCC_motor_sum, aes(x= year, y= Emissions, fill=Emissions)) +
  geom_bar( stat = "identity") + 
  geom_text(aes(label = round(Emissions, 1)), vjust = -0.3)+
  facet_wrap(~city) +
  #theme_bw() +
  labs(title = "PM2.5 Emissions of motor vehicle sources-Baltimore vs Los Angeles 1999-2008")

#Close the png file
dev.off()
