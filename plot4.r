#load data
#setwd("D:/dev/coursera/exploratory data analysis")
getwd()
#[1] "D:/dev/coursera/exploratory data analysis"
library(dplyr)
data <- read.csv("household_power_consumption.txt", header = TRUE, dec=".", sep =";", stringsAsFactors=FALSE)
nrow(data)
#[1] 2075259
head(data)
#Date Time Global_active_power Global_reactive_power Voltage
#1 16/12/2006 17:24:00 4.216 0.418 234.840
#2 16/12/2006 17:25:00 5.360 0.436 233.630
#3 16/12/2006 17:26:00 5.374 0.498 233.290
#4 16/12/2006 17:27:00 5.388 0.502 233.740
#5 16/12/2006 17:28:00 3.666 0.528 235.680
#6 16/12/2006 17:29:00 3.520 0.522 235.020
#Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
#1 18.4000.0001.000 17
#2 23.0000.0001.000 16
#3 23.0000.0002.000 17
#4 23.0000.0001.000 17
#5 15.8000.0001.000 17
#6 15.0000.0002.000 17
subData <- filter(data, Date %in% c("1/2/2007", "2/2/2007")) 
nrow(subData)
#[1] 2880
apower    <- select(subData, Global_active_power) %>% sapply(as.numeric)

timestamp <- select(subData, Date, Time) 
timestamp <- strptime(paste(timestamp$Date, timestamp$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

sub1 <- select(subData, Sub_metering_1) %>% sapply(as.numeric)
sub2 <- select(subData, Sub_metering_2) %>% sapply(as.numeric)
sub3 <- select(subData, Sub_metering_3) %>% sapply(as.numeric)

volt <- select(subData, Voltage) %>% sapply(as.numeric)

rpower <- select(subData, Global_reactive_power) %>% sapply(as.numeric)

png(filename = "plot4.png", width = 480, height = 480, pointsize = 11)
op <- par(mfrow = c(2, 2))#, pty = "s")       

plot(timestamp, apower, col = "Black", bg = "White", type="l", xlab = " ", ylab="Global Active Power")
plot(timestamp, volt, col = "Black", bg = "White", type="l", xlab = "datetime", ylab="Voltage")
plot(timestamp, sub1, col = "Black", bg = "White", type="l", xlab = " ", ylab="Energy sub metering")
 lines(timestamp, sub2, type="l", col="Red")
 lines(timestamp, sub3, type="l", col="Blue")
 legend("topright", bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black", "Red", "Blue"), lty=1)
plot(timestamp, rpower, col = "Black", bg = "White", type="l", xlab = "datetime", ylab="Global_reactive_power")

par(op)
dev.off()
