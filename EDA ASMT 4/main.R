# set working directory

setwd("C:/Users/user-pc/Documents/Bedant Data Science/EDA ASMT 4")
ls()
library(ggplot2)
library(dplyr)

# Download PM2.5 pollutant data
get.pm25.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(get.pm25.url,destfile="./exdata-data-NEI_data.zip",method="auto")  
unzip(zipfile="./exdata-data-NEI_data.zip",exdir=".")

# Read data files
# read national emissions data * Source classification data
NEIdata <- readRDS("summarySCC_PM25.rds")
SCCdata <- readRDS("Source_Classification_Code.rds")
#str(NEIdata)
#dim(NEIdata)
#head(NEIdata)
#str(SCCdata)
#dim(SCCdata)
#head(SCCdata)


