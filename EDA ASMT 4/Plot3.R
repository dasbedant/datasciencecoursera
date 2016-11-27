# Question---3
#Of the four types of sources indicated by the 
#type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions 
#from 1999-2008 for Baltimore City?
library(ggplot2)

# Loading provided datasets - loading from local machine
PM25data <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")

BLT <- subset(PM25data, fips=='24510')
YearlYAggregate <- with(BLT, aggregate(Emissions, by = list(type, year), sum))
colnames(YearlYAggregate) <- c("type","year","pm25","pm25inK")
YearlYAggregate$year <- factor(YearlYAggregate$year, levels=c('1999', '2002', '2005', '2008'))
head(YearlYAggregate)

# Generate the graph in the same directory as the source code
png(filename='plot3.png', width=800, height=500, units='px')
qplot(year, pm25, 
      data = YearlYAggregate, color= type, geom= "line")+ 
      ggtitle("Total PM2.5 Emissions in Baltimore County by Source Type")+
      xlab("Year") + ylab("PM2.5 Emissions")    
dev.off()
