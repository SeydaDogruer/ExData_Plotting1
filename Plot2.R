library(dplyr)
library(lubridate)

data <- read.table("household_power_consumption.txt", sep=";", fill=FALSE, 
                   na.strings = "?", strip.white=TRUE, header = TRUE)

subset_data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
subset_data <- mutate(subset_data, 
                      Date = paste(Date, Time), 
                      Time = NULL)
subset_data$Date <- strptime(subset_data$Date, format = "%d/%m/%Y %H:%M:%S")


png(file = "plot2.png")
with(subset_data, plot(Global_active_power ~ as.POSIXct(Date), type = "l",
       ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
