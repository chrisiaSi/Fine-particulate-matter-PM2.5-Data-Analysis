## Explore the National Emissions Inventory database 
## and see what it say about fine particulate matter pollution in the United states 
## over the 10-year period 1999–2008

#2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008?
#Ans: YES
#Use the base plotting system to make a plot answering this question.

## Read NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_baltimore <- subset(NEI, fips=="24510")
emissionsSum_baltimore <- data.frame(with(NEI_baltimore, tapply(Emissions, year, sum, na.rm=TRUE)))
rownames(emissionsSum_baltimore)


#Open a png file to write the data
png(file = "plot2.png", width = 650, height = 480)

options(scipen=10000)

#Create plot with PM2.5 emissions for 1999, 2002, 2005, and 2008
plot(rownames(emissionsSum_baltimore), emissionsSum_baltimore[[1]], type = "b", pch=19, col="purple",xaxt = "n", main = "PM2.5 Emissions for Baltimore from 1999 to 2008", xlab = "Years", ylab = "PM2.5 Emissions")
axis(1, at= rownames(emissionsSum_baltimore), labels = rownames(emissionsSum_baltimore) )

#Close the png file
dev.off()
