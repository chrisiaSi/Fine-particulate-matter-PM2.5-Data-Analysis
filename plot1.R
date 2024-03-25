## Explore the National Emissions Inventory database 
## and see what it say about fine particulate matter pollution in the United states 
## over the 10-year period 1999–2008

#1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Ans: YES
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

## Read NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsSum <- data.frame(with(NEI, tapply(Emissions, year, sum, na.rm=TRUE)))
typeof(rownames(emissionsSum))

#Open a png file to write the data
png(file = "plot1.png", width = 650, height = 480)

options(scipen=10000)

#Create plot with PM2.5 emissions for 1999, 2002, 2005, and 2008
plot(rownames(emissionsSum), emissionsSum[[1]], type = "b", pch=19, col="blue",xaxt = "n", main = "PM2.5 Emissions for Years 1999, 2002, 2005, 2008", xlab = "Years", ylab = "PM2.5 Emissions")
axis(1, at= rownames(emissionsSum), labels = rownames(emissionsSum) )

#Close the png file
dev.off()

