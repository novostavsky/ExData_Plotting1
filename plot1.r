#load data
#setwd("D:/dev/coursera/exploratory data analysis")
getwd()
#[1] "D:/dev/coursera/exploratory data analysis"
library(dplyr)
data <- read.csv("household_power_consumption.txt", header = TRUE, dec=".", sep =";", stringsAsFactors=FALSE)
nrow(data)
#[1] 2075259
subData <- filter(data, Date %in% c("1/2/2007", "2/2/2007")) %>% select(Global_active_power) %>% sapply(as.numeric)
nrow(subData)
#[1] 2880
head(subData)
#     Global_active_power
#[1,]               0.326
#[2,]               0.326
#[3,]               0.324
#[4,]               0.324
#[5,]               0.322
#[6,]               0.320

#plot
png(filename = "plot1.png", width = 480, height = 480, pointsize = 14)

hist(subData, bg = "White", col="Red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab = "Frequency")

dev.off()