##Download zipfile, unzip and read table into dataframe
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

##Plot histogram and save to png format
png('plot1.png',bg = "transparent", width = 480, height = 480, units = "px")
hist(dataFinal$Global_active_power, col="red", main='Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.off()