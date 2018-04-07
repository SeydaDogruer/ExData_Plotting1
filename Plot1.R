library(dplyr)
library(lubridate)

data <- read.table("household_power_consumption.txt", sep=";", fill=FALSE, 
                   na.strings = "?", strip.white=TRUE, header = TRUE)

subset_data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
subset_data <- mutate(subset_data, 
                      Date = paste(Date, Time), 
                      Time = NULL)
subset_data$Date <- strptime(subset_data$Date, format = "%d/%m/%Y %H:%M:%S")


png(file = "plot1.png")
with(subset_data, hist(Global_active_power, col = "red",
                       main = "Global Active Power", 
                       xlab = "Global Active Power (kilowatts)", ylab="Frequency"))
dev.off()
