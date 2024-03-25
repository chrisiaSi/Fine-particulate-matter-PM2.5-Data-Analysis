## Explore the National Emissions Inventory database 
## and see what it say about fine particulate matter pollution in the United states 
## over the 10-year period 1999–2008

#3. Of the four types of sources indicated by type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Ans: Non-road, Nonpoint and On-road sources have seen a decrease
#Which have seen increases in emissions from 1999–2008? 
#Ans: Point sources have seen an increase
#Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

## Read NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_baltimore <- subset(NEI, fips=="24510")

emissionsSum_baltimore <- data.frame(as.table(with(NEI_baltimore, tapply(Emissions, list("year"=year, "type"=type), sum, na.rm=TRUE, simplify = TRUE))))

colnames(emissionsSum_baltimore)[3] <- "Emissions"

#Open a png file to write the data
png(file = "plot3.png", width = 650, height = 480)

options(scipen=10000)

#Create plot of PM2.5 Emissions for Baltimore by sources from 1999-2008
ggplot(emissionsSum_baltimore, aes(x= year, y= Emissions, group=1)) +
  geom_point()+geom_line(aes(color = Emissions)) + 
  geom_text(aes(label = round(Emissions, 1)), vjust = "outward", hjust = "outward")+
  facet_wrap(~type) +
  labs(title = "PM2.5 Emissions for Baltimore by sources 1999-2008") +
  scale_color_gradientn(colours = rainbow(3))

#Close the png file
dev.off()
