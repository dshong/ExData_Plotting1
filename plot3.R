source_url <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
zipdata <- tempfile()
download.file(source_url, zipdata, method = "curl")
data <- read.table(unz(zipdata, "household_power_consumption.txt"), sep = ";", header = T, colClasses = c("character", "character", rep("numeric", 7)), na.strings = "?")

##Subset data to include range from 2/1/2007-2/2/2007 and convert date into POSIXlt date/time format
data01 = subset(data, data$Date == "1/2/2007")
data02 = subset(data, data$Date == "2/2/2007")
dataFinal = rbind(data01,data02)
dataFinal$Date <- strptime(paste(dataFinal$Date, dataFinal$Time), "%d/%m/%Y %H:%M:%S")

##Plot multiple line graphs with legend and save to png format
png('plot3.png',bg = "transparent", width = 480, height = 480, units = "px")
plot(dataFinal$Sub_metering_1 ~ as.POSIXct(dataFinal$Date), type = "l", ylab = "Energy sub metering", xlab = "")
lines(dataFinal$Sub_metering_2 ~ as.POSIXct(dataFinal$Date), col = "red")
lines(dataFinal$Sub_metering_3 ~ as.POSIXct(dataFinal$Date), col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1), lwd=c(1,1))
dev.off()