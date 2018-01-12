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
for (i in 3:9) {mydf[,i]=as.numeric(mydf[,i])}

#Plotting the histogram and saving a PNG image
png(file = "plot1.png", width = 480, height = 480)
hist(na.omit(mydf[,3]),main="Global Active Power",xlab="Global Active Power (kilowatts)", col="red")
dev.off()