#####Plot2.R
filepath <- "./data/household_power_consumption.txt"
d1 <- read.table(filepath, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
mnthdata <- d1ta[d1$Date %in% c("1/2/2007","2/2/2007") ,]

#str(mnthdata)
datetime <- strptime(paste(mnthdata$Date, mnthdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(mnthdata$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
