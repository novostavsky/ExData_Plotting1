#load data
#setwd("D:/dev/coursera/exploratory data analysis")
getwd()
#[1] "D:/dev/coursera/exploratory data analysis"
library(dplyr)
data <- read.csv("household_power_consumption.txt", header = TRUE, dec=".", sep =";", stringsAsFactors=FALSE)
nrow(data)
#[1] 2075259
subData <- filter(data, Date %in% c("1/2/2007", "2/2/2007")) 
nrow(subData)
#[1] 2880
head(subData)
#      Date     Time Global_active_power Global_reactive_power Voltage
#1 1/2/2007 00:00:00               0.326                 0.128 243.150
#2 1/2/2007 00:01:00               0.326                 0.130 243.320
#3 1/2/2007 00:02:00               0.324                 0.132 243.510
#4 1/2/2007 00:03:00               0.324                 0.134 243.900
#5 1/2/2007 00:04:00               0.322                 0.130 243.160
#6 1/2/2007 00:05:00               0.320                 0.126 242.290
#  Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
#1            1.400          0.000          0.000              0
#2            1.400          0.000          0.000              0
#3            1.400          0.000          0.000              0
#4            1.400          0.000          0.000              0
#5            1.400          0.000          0.000              0
#6            1.400          0.000          0.000              0

apower    <- select(subData, Global_active_power) %>% sapply(as.numeric)
timestamp <- select(subData, Date, Time) 
timestamp <- strptime(paste(timestamp$Date, timestamp$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
sub1 <- select(subData, Sub_metering_1) %>% sapply(as.numeric)
sub2 <- select(subData, Sub_metering_2) %>% sapply(as.numeric)
sub3 <- select(subData, Sub_metering_3) %>% sapply(as.numeric)

#plot
png(filename = "plot3.png", width = 480, height = 480, pointsize = 14)

plot(timestamp, sub1, col = "Black", bg = "White", type="l", xlab = " ", ylab="Energy sub metering")
lines(timestamp, sub2, type="l", col="Red")
lines(timestamp, sub3, type="l", col="Blue")
legend("topright", border = "Black", bg = "White", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black", "Red", "Blue"), lty=1)

dev.off()


