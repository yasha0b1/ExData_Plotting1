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
dev.copy(png,filename="plot1.png")
dev.off()
