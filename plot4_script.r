library(lubridate)
library(plyr)
library(dplyr)


#         
# Specify the date range we will be using.
date.range <- c("2007-02-01", "2007-02-02")
raw.data <- read.table(file = "household_power_consumption.txt",sep = ";",na.strings = "?",header=TRUE)
raw.data$Date <- dmy(raw.data$Date)
rel.data <- filter(raw.data,Date >= date.range[1], Date <= date.range[2])
timestamp <- paste(rel.data$Date,rel.data$Time)
rel.data$DateTime <-  strptime(timestamp,format ="%Y-%m-%d %H:%M:%S" )

png(file = "plot4.png",width = 480,height = 480)
par(mfrow = c(2,2)  )
with(rel.data , plot(DateTime,Global_active_power,xlab = "",ylab = "Global Active Power","l"))
with(rel.data , plot(DateTime,Voltage,xlab = "datetime",ylab = "Voltage","l"))

plot(rel.data$DateTime,rel.data$Sub_metering_1,ylab = "Energy sub metering",xlab = "",type = "l")
lines(rel.data$DateTime,rel.data$Sub_metering_2,col="red")
lines(rel.data$DateTime,rel.data$Sub_metering_3,col="blue")
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


with(rel.data , plot(DateTime,Global_reactive_power,xlab = "datetime","l"))
dev.off()