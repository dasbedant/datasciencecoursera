####Plot3.R

filepath <- "./data/household_power_consumption.txt"
d1 <- read.table(filepath, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
mnthdata <- d1[d1$Date %in% c("1/2/2007","2/2/2007") ,]

datetime <- strptime(paste(mnthdata$Date, mnthdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(mnthdata$Global_active_power)
subMetering1 <- as.numeric(mnthdata$Sub_metering_1)
subMetering2 <- as.numeric(mnthdata$Sub_metering_2)
subMetering3 <- as.numeric(mnthdata$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Sub metering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
