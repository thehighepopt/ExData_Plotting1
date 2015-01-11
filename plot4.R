## directory is a character string representing the directory where
## you unpacked the power consumption data set, assuming you didn't 
## rename the folders.

plotting <- function(directory) {
  setwd(directory) 
  electric <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 2880, skip = 66636)
  colnames(electric) <- unlist(read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", nrows = 1))
  electric$Date <- as.Date(electric$Date, format = "%d/%m/%Y")
  ##electric$Time <- strptime(electric$Time,"%H:%M:%S")
  electric$DateTime <- as.POSIXct(with(electric, paste(Date,Time)), tz ="GMT")
  
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(electric, {
  plot(DateTime,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  {
    plot(DateTime,Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub metering")
    lines(DateTime, Sub_metering_2, col ="red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", pch = 45, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  }
  plot(DateTime,Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")
})
dev.off()
}