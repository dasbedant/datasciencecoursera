# Question---2
#Have total emissions from PM2.5 decreased in the 
#Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

# Loading provided datasets - loading from local machine
PM25data <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")

Baltimoredata <- subset(PM25data, fips=='24510')
YearlYAggregate <- with(Baltimoredata, aggregate(Emissions, by = list(year), sum))
YearlYAggregate$PM <- round(YearlYAggregate[,2]/1000,2)
head(YearlYAggregate)


# Generate the graph in the same directory as the source code
png("plot2.png", width=480, height=480)
plot(YearlYAggregate[,1],YearlYAggregate$PM,
     type = "o", 
     main = "Total Emission in Baltimore City, Maryland", 
     xlab = "Year", ylab = "PM2.5 Emissions in Kilotons", 
     pch = 23, col = "dark red", lty = 1, lwd =2)

dev.off()
