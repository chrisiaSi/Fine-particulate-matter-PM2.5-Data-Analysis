## Explore the National Emissions Inventory database 
## and see what it say about fine particulate matter pollution in the United states 
## over the 10-year period 1999–2008

#5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#Ans: Emissions from motor vehicle sources decreased from 1999-2008 in Baltimore city

library(ggplot2)
library(dplyr)

## Read NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_baltimore <- subset(NEI, fips=="24510")

SCC_motor <- SCC %>% filter(grepl('[Vv]ehicle', EI.Sector))

NEI_SCC_motor <- merge(NEI_baltimore, SCC_motor, by = "SCC")
NEI_SCC_motor_sum <- data.frame(as.table(with(NEI_SCC_motor, tapply(Emissions, list("year"=year), sum, na.rm=TRUE, simplify = TRUE))))
colnames(NEI_SCC_motor_sum)[2] <- "Emissions"


#Open a png file to write the data
png(file = "plot5.png", width = 650, height = 480)

options(scipen=10000)

qplot(year, Emissions, data = NEI_SCC_motor_sum, colour = Emissions, geom = c("auto", "path"), group=1, main = "PM2.5 Emissions from Motor Vehicles from 1999-2008 in Baltimore")

#Close the png file
dev.off()
