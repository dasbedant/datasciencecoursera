# set working directory

setwd("C:/Users/user-pc/Documents/Bedant Data Science/RR ASMT 4")
ls()
library(ggplot2)
library(dplyr)
library(knitr)
#This assignment makes use of data from a personal activity 
#monitoring device. This device collects data at 5 minute intervals
#through out the day. The data consists of two months of data from 
#an anonymous individual collected during the months of 
#October and November, 2012 and include the number of steps taken 
#in 5 minute intervals each day.

#The data for this assignment can be downloaded from the course web site:
get.Activity.url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(get.Activity.url,destfile="./activity.zip",method="auto")  
unzip(zipfile="./activity.zip",exdir=".")

# Read data file- ACTIVITY.csv
act1 <- read.csv("activity.csv")

str(act1)
dim(act1)
head(act1)

#Histogram of the total number of steps taken each day
#Mean and median number of steps taken each day
total_steps <- tapply(act1$steps, act1$date, FUN=sum, na.rm=TRUE)
qplot(total_steps, binwidth=1000, xlab="total number of steps taken each day")
mean(total_steps, na.rm=TRUE)
median(total_steps, na.rm=TRUE)

#Time series plot of the average number of steps taken
#The 5-minute interval that, on average, contains the maximum number of steps

AvgSteps <- aggregate(x=list(steps=act1$steps), by=list(interval=act1$interval),
                      FUN=mean, na.rm=TRUE)
ggplot(data=AvgSteps, aes(x=interval, y=steps)) +
  geom_line() +
  xlab("5-minute interval") +
  ylab("average number of steps taken")

## ------------------------------------------------------------------------
AvgSteps[which.max(AvgSteps$steps),]


# how many missing data ???
missing <- is.na(act1$steps)
table(missing)


# Strategy is to replace each missing value with the mean value 
# of its 5-minute interval
## Function FillMissingVlaue
FillMissingValue <- function(steps, interval) {
  filled <- NA
  if (!is.na(steps))
    filled <- c(steps)
  else
    filled <- (AvgSteps[AvgSteps$interval==interval, "steps"])
  return(filled)
}
filled.act1 <- act1
filled.act1$steps <- mapply(FillMissingValue, filled.act1$steps, filled.act1$interval)

#Histogram of the total number of steps taken each day after missing values 
#are imputed

total_steps <- tapply(filled.act1$steps, filled.act1$date, FUN=sum)
qplot(total_steps, binwidth=1000, xlab="total number of steps taken each day")
mean(total_steps)
median(total_steps)



#Function to check whther the given date is WeeKday or Weekend?
GetWeekend <- function(date) {
  day <- weekdays(date)
  if (day %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))
    return("weekday")
  else if (day %in% c("Saturday", "Sunday"))
    return("weekend")
  else
    stop("invalid date")
}
filled.act1$date <- as.Date(filled.act1$date)
filled.act1$day <- sapply(filled.act1$date, FUN=GetWeekend)


#Panel plot comparing the average number of steps taken per 5-minute interval
#across weekdays and weekends



AvgSteps <- aggregate(steps ~ interval + day, data=filled.act1, mean)
ggplot(AvgSteps, aes(interval, steps)) + 
  geom_line(colour= "red") + facet_grid(day ~ .) +
  ggtitle(" Panel plot comparing average steps across Weekdays & Weekend") +
  xlab("5-minute interval") + ylab("Number of steps")