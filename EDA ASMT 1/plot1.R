####Plot1.R

filepath <- "./data/household_power_consumption.txt"
d1 <- read.table(filepath, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
mnthdata <- d1[d1$Date %in% c("1/2/2007","2/2/2007") ,]

str(mnthdata)

globalActivePower <- as.numeric(mnthdata$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")
rug(globalActivePower)
dev.off()
