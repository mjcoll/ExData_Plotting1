# Read in the data, which is assumed to be saved in the repository
# Only read in the the rows corresponding to 2/1/2007 - 2/2/2007
power_data <- read.table("../household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", colClasses = c("character", "character", rep("numeric", 7)), nrows = 2880, skip = 66637)

# Headers not read in with data; add them here
names(power_data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Combine Date and Time columns into a new column of class POSIXct
power_data$datetime <- as.POSIXct(paste(power_data$Date, power_data$Time), format = "%d/%m/%Y %H:%M:%S")

# Create and save the plot
png("plot3.png")
with(power_data, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(power_data, points(datetime, Sub_metering_2, col = "red", type = "l"))
with(power_data, points(datetime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()