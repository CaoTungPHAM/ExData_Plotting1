#Before anything, make sure that the working directory contains "household_power_consumption.txt"
mydf <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,stringsAsFactors = FALSE)

#To maniplutate date and time, we load the package "lubridate"
library(lubridate)

#We change the format of Date as follow:
mydf$Date <- dmy(mydf$Date)

#subsetting the data set 
x<-mydf$Date[1]
y<-update(x,years=2007,months=02,days=01)
mydf <- subset(mydf,Date == y | Date == y +days(1))

#Using as.numeric to convert from "charater" to "numeric" where it is needed, "?" will be automatically replaced by NA
#then eliminate the NAs values
for (i in 3:9) {mydf[,i]=as.numeric(mydf[,i])}
mydf <- na.omit(mydf)

#Manipulating date&time before plotting (we need the package tidyr for that)
library(tidyr)
mydf <- unite(mydf, "DateTime", c("Date", "Time"), sep = " ")
mydf$DateTime = as.POSIXct(mydf$DateTime)

#changing language system before plotting 
Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")

#Plotting the histogram and saving a PNG image
png(file = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(mydf$Global_active_power~mydf$DateTime,type="l",xlab=" ",ylab="Global Active Power")
plot(mydf$DateTime, mydf$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(mydf$DateTime, mydf$Sub_metering_1, col = "black", type = "l", xlab =" ", ylab = "Energy Sub Metering")
lines(mydf$DateTime, mydf$Sub_metering_2, col = "red")
lines(mydf$DateTime, mydf$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red","blue"), lty = rep(1,3),bty="n")
plot(mydf$DateTime, mydf$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()