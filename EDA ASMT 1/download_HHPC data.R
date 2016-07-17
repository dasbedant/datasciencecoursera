rm(list=ls())
myhomedirectory <-"C:/Users/user-pc/Documents/Bedant Data Science/datasciencecoursera"
setwd(myhomedirectory)
getwd()
library(jpeg)
library(data.table)
library(dplyr)
library(Hmisc)


#Download Zip file & Unzip
fileurl1 = 'https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip'
dst4 = './data/household_power_consumption.zip'
download.file(fileurl1, dst4)
unzip(zipfile="./data/household_power_consumption.zip",exdir="./data")
#path_ds <- file.path("./data" , "UCI HAR Dataset")
#files<-list.files(path_ds, recursive=TRUE)


