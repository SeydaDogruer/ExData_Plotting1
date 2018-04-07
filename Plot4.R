library(dplyr)
library(lubridate)

data <- read.table("household_power_consumption.txt", sep=";", fill=FALSE, 
                   na.strings = "?", strip.white=TRUE, header = TRUE)

subset_data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
subset_data <- mutate(subset_data, 
                      Date = paste(Date, Time), 
                      Time = NULL)
subset_data$Date <- strptime(subset_data$Date, format = "%d/%m/%Y %H:%M:%S")

png(file = "plot4.png")

par(mfrow = c(2, 2))

with(subset_data, plot(Global_active_power ~ as.POSIXct(Date), type = "l",
                       ylab = "Global Active Power", xlab = ""))

with(subset_data, plot(Voltage ~ as.POSIXct(Date), type = "l",
                       ylab = "Voltage", xlab = "datetime"))

with(subset_data, {plot(Sub_metering_1 ~ as.POSIXct(Date), type = "l",
                        xlab = "", ylab = "Energy sub metering")
  lines(Sub_metering_2 ~ as.POSIXct(Date), col = "red")
  lines(Sub_metering_3 ~ as.POSIXct(Date), col = "blue")})
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, lwd = 2)

with(subset_data, plot(Global_reactive_power ~ as.POSIXct(Date), type = "l",
                       ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()




