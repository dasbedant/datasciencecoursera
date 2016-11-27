#Question --- 1.
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# Loading provided datasets - loading from local machine
PM25data <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")

YearlYAggregate <- with(PM25dta, aggregate(Emissions, by = list(year), sum))
YearlYAggregate$PM <- round(YearlYAggregate[,2]/1000,2)
#head(YearlYAggregate)

# Generate the graph in the same directory as the source code
png("plot1.png", width=480, height=480)
plot(YearlYAggregate[,1],YearlYAggregate$PM,
     type = "o", 
     main = "Total PM2.5 Emissions", 
     xlab = "Year", ylab = "PM2.5 Emissions in Kilotons", 
     pch = 23, col = "dark red", lty = 1, lwd =2)

dev.off()
