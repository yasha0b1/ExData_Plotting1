url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp, mode="rb")
pdata <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE,  sep=";",na.strings = "?")
unlink(temp)
dates <- pdata$Date
times <-pdata$Time
x <- paste(dates, times)
pdata$Datetime<-strptime(x, "%d/%m/%C%y %H:%M:%S")
data<-subset(pdata, Datetime > strptime("01/02/2007","%d/%m/%C%y") &Datetime < strptime("02/02/2007","%d/%m/%C%y") )


#part3 
with(data,plot(Datetime,Sub_metering_1, type="l",xlab = "", ylab="Energy Sub Metering",col="grey"))
points(data$Datetime, data$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(data$Datetime, data$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,filename="plot3.png")
dev.off()

