# Question---5
# How have emissions from motor vehicle sources 
# changed from 1999-2008 in Baltimore City? 

library(ggplot2)

# Loading provided datasets - loading from local machine
PM25data <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")
BLT <- subset(PM25data, fips=='24510' & type == "ON-ROAD")
YearlYAggregate <- with(BLT, aggregate(Emissions, by = list(type, year), sum))
colnames(YearlYAggregate) <- c("type","year","pm25")
YearlYAggregate$year <- factor(YearlYAggregate$year, levels=c('1999', '2002', '2005', '2008'))
head(YearlYAggregate)


# Generate the graph in the same directory as the source code
png("plot5.png")

ggplot(data=YearlYAggregate, aes(x=as.factor(year),y=pm25)) +
  geom_bar(stat="identity",fill="darkorange3") +
  labs(title=expression("Total PM" [2.5]*" Motor Vehicle Emissions for Baltimore City, MD USA")) +
  labs(x="Year", y=expression("PM"[2.5]*" Emissions (tons)"))
dev.off()