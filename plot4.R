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
#part1 
hist(data$Global_active_power, main = "Global Active Power", col = "red", xlab="Global Active Power (kilowatts)",ylab = "Frequency")
#part2 
plot(data$Date, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png,filename="plot1.png")
dev.off()
with(data,plot(Datetime, Global_active_power, type="l",xlab = "", ylab="Global Active Power (kilowatts)"))
dev.copy(png,filename="plot2.png")
dev.off()


#part3 
with(data,plot(Datetime,Sub_metering_1, type="l",xlab = "", ylab="Energy Sub Metering",col="grey"))
points(data$Datetime, data$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(data$Datetime, data$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,filename="plot3.png")
dev.off()
#part4
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(data,{
  plot(Datetime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
  plot(Datetime, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Datetime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
  points(Datetime, data$Sub_metering_2, type = "l", xlab = "", ylab = "Sub_metering_2", col = "red")
  points(Datetime, data$Sub_metering_3, type = "l", xlab = "", ylab = "Sub_metering_3", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n", )
  plot(Datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0, 0.5))
})
dev.copy(png,filename="plot4.png")
dev.off()