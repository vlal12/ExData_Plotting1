library(dplyr)
library(lubridate)

all_data<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
tidydata<-filter(all_data, Date=="2/2/2007"|Date=="1/2/2007")
# t<-sapply(tidydata, is.factor)
# tidydata[t]<-lapply(tidydata[t], as.character)
tidydata$newdate<-dmy_hms(paste(tidydata$Date, tidydata$Time))
tidydata$datetime<-as.POSIXlt(tidydata$newdate)

par(mfrow=c(2,2))
plot(tidydata$datetime,tidydata$Global_active_power,type="l", xlab="", ylab="Global Active Power")
plot(tidydata$datetime,tidydata$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(tidydata$datetime, tidydata$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", cex=5, yaxp=c(0,40,4))
lines(tidydata$datetime, tidydata$Sub_metering_2, col="red")
lines(tidydata$datetime, tidydata$Sub_metering_3, col="blue")
plot(tidydata$datetime, tidydata$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
dev.copy(png, file="plot4.png")
dev.off()