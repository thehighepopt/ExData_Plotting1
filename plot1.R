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

png(filename = "plot1.png", width = 480, height = 480)
hist(electric$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
}


