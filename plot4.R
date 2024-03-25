## Explore the National Emissions Inventory database 
## and see what it say about fine particulate matter pollution in the United states 
## over the 10-year period 1999–2008

#4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#Ans: The emissions from coal combustion-related sources have decreased from 1999-2008

library(ggplot2)
library(dplyr)

## Read NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_coal <- SCC %>% filter(grepl('[Cc]oal', EI.Sector))
  
NEI_SCC_coal <- merge(NEI, SCC_coal, by = "SCC")
NEI_SCC_coal_sum <- data.frame(as.table(with(NEI_SCC_coal, tapply(Emissions, list("year"=year), sum, na.rm=TRUE, simplify = TRUE))))
colnames(NEI_SCC_coal_sum)[2] <- "Emissions"


#Open a png file to write the data
png(file = "plot4.png", width = 650, height = 480)

options(scipen=10000)

qplot(year, Emissions, data = NEI_SCC_coal_sum, colour = Emissions, geom = c("auto", "path"), group=1, main = "PM2.5 Emissions from coal combustion-related sources 1999-2008")

#Close the png file
dev.off()
