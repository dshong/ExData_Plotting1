source_url <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
zipdata <- tempfile()
download.file(source_url, zipdata, method = "curl")
data <- read.table(unz(zipdata, "household_power_consumption.txt"), sep = ";", header = T, colClasses = "character")

##Subset data to include range from 2/1/2007-2/2/2007 and convert date into POSIXlt date/time format
data01 = subset(data, data$Date == "1/2/2007")
data02 = subset(data, data$Date == "2/2/2007")
dataFinal = rbind(data01,data02)
dataFinal$Date <- strptime(paste(dataFinal$Date, dataFinal$Time), "%d/%m/%Y %H:%M:%S")

##Convert character column into numeric formate for plotting
dataFinal$Global_active_power = as.numeric(dataFinal$Global_active_power)
dataFinal$Voltage = as.numeric(dataFinal$Voltage)
dataFinal$Global_reactive_power = as.numeric(dataFinal$Global_reactive_power)
dataFinal$Sub_metering_1 = as.numeric(dataFinal$Sub_metering_1)
dataFinal$Sub_metering_2 = as.numeric(dataFinal$Sub_metering_2)
dataFinal$Sub_metering_3 = as.numeric(dataFinal$Sub_metering_3)

##Construct 2x2 template for four plots and save to png format
png('plot4.png',bg = "transparent", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

##Plot1
plot(dataFinal$Global_active_power ~ as.POSIXct(dataFinal$Date), type = "l",ylab = "Global Active Power", xlab = "")

##Plot2
plot(dataFinal$Voltage ~ as.POSIXct(dataFinal$Date), type = "l",ylab = "Voltage", xlab = "datetime")

##Plot3
plot(dataFinal$Sub_metering_1 ~ as.POSIXct(dataFinal$Date), type = "l", ylab = "Energy sub metering", xlab = "")
lines(dataFinal$Sub_metering_2 ~ as.POSIXct(dataFinal$Date), col = "red")
lines(dataFinal$Sub_metering_3 ~ as.POSIXct(dataFinal$Date), col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1), lwd=c(1,1), bty = "n")

##Plot4
plot(dataFinal$Global_reactive_power ~ as.POSIXct(dataFinal$Date), type = "l",ylab = "Global_reactive_power ", xlab = "datetime")

dev.off()