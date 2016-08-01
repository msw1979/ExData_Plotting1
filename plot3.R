#plot3 code
fileName <- file("household_power_consumption.txt") # define a fileName for the full data file
# read the data for 2007-02-01 and 2007-02-02
data <- read.table(text = grep("^[1,2]/2/2007", readLines(fileName), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

## Converting dates and time
data$Date <- as.Date(data$Date, format = "%d/%m/%Y") # change Date format
DateTime <- paste(as.Date(data$Date), data$Time) #Define DateTime
data$DateTime <- as.POSIXct(DateTime)

# Open PNG device; create 'plot3.png'
png(file = "plot3.png", width = 480, height = 480, units = "px")

## Generating Plot 3
with(data, {
  plot(Sub_metering_1 ~ DateTime, col="black", type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ DateTime, col = 'red')
  lines(Sub_metering_3 ~ DateTime, col = 'blue')
})

#Add legend
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() ## Close the png file device