library(lubridate)
library(plyr)
library(dplyr)


         
# Specify the date range we will be using.
date.range <- c("2007-02-01", "2007-02-02")
raw.data <- read.table(file = "household_power_consumption.txt",sep = ";",na.strings = "?",header=TRUE)
raw.data$Date <- dmy(raw.data$Date)
rel.data <- filter(raw.data,Date >= date.range[1], Date <= date.range[2])
timestamp <- paste(rel.data$Date,rel.data$Time)
rel.data$DateTime <-  strptime(timestamp,format ="%Y-%m-%d %H:%M:%S" )

# Add weekday factors and fix the time:
png(file = "plot2.png",width = 480,height = 480)
rel.data$weekday<- as.factor(weekdays(rel.data$Date))
with(rel.data,plot(DateTime,Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)",xlab = "")   )
dev.off()