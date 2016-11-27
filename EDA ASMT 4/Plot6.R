# Question---6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time 
# in motor vehicle emissions?

library(ggplot2)

# Loading provided datasets - loading from local machine
PM25data <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland
# Los Angeles County, California
BLT <- subset(PM25data, fips == '24510' & type == 'ON-ROAD')
LA <- subset(PM25data, fips == '06037' & type == 'ON-ROAD')

# Aggregate
BLTsub <- aggregate(BLT[, 'Emissions'], by=list(BLT$year), sum)
colnames(BLTsub) <- c('year', 'PM25')
BLTsub$State <- paste(rep('MD', 4))

LAsub <- aggregate(LA[, 'Emissions'], by=list(LA$year), sum)
colnames(LAsub) <- c('year', 'PM25')
LAsub$State <- paste(rep('CA', 4))

YearlYAggregate <- as.data.frame(rbind(BLTsub, LAsub))
head(YearlYAggregate)
# Generate the graph in the same directory as the source code
png('plot6.png')

ggplot(data=YearlYAggregate, aes(x=factor(year), y=round(PM25,0),fill=State )) +
  geom_bar(stat="identity") + guides(fill=FALSE) + 
  facet_grid(.~State, scales = "free",space="free") +
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
  ylab('PM25')+ xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(PM25,0), size=1, hjust=0.5, vjust=-1))

dev.off()