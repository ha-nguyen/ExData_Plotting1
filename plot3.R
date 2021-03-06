# Author - Ha Nguyen
# Course - Explaintory Data Analysis 
# Project 1 - Analyze individual household electric power consumption Data Set
## Examine how household energy usage varies over 2 day period in Feb - 2007

# Getting data file 
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "/Users/akira_6686/Downloads/datasets/house_power_consump.zip"
download.file(url = fileurl, destfile = destfile , method = "curl")
unzip(zipfile = destfile, exdir = "/Users/akira_6686/Downloads/datasets/")

# Loading package 
library(data.table)
power_consump <- fread("/Users/akira_6686/Downloads/datasets/household_power_consumption.txt", sep = ";", na.strings = "?")

# Filter only two day: 1/2/2007 and 2/2/2007 
power_consump.12 <- as.data.frame(power_consump[power_consump$Date %in% list("1/2/2007","2/2/2007")])

# Make a new column to save Date and time
power_consump.12$DateTime <- strptime(paste(power_consump.12$Date, power_consump.12$Time), format = "%d/%m/%Y %H:%M:%S")

#Convert numeric columns to correct type 
power_consump.12[, 3:9] <- as.data.frame(lapply(power_consump.12[,3:9], as.numeric))

#Create graphs and save to PNG file 

png("plot3.png", width = 480, height = 480)
# Time series plot of Energy Sub metering usage during two days 
with(power_consump.12, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", col = "black", type = "l"))
with(power_consump.12, points(DateTime, Sub_metering_2, col = "red", type = "l"))
with(power_consump.12, points(DateTime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", col = c("black", "red", "blue"), lwd = 3, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
