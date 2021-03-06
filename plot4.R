## READ AND DATA MANIPULATION
#See format of file from 1st 2 lines
readLines("household_power_consumption.txt",2);

#Read in data (header = TRUE, sep = ";", stringsAsFactors=FALSE)
mydata <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";",stringsAsFactors=FALSE)

# manipulate data - subset 
mydata2 <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007")
#create DateTime column
mydata2 <- within(mydata2,  DateTime <- paste(Date, Time, sep=" "))
mydata2$DateTime <- strptime(mydata2$DateTime,"%d/%m/%Y %H:%M:%S")

# Transform Date column to Date type and drop Time
mydata2$Date <- as.Date(mydata2$Date, "%d/%m/%Y")
mydata2 <- mydata2[,!(names(mydata2) %in% c("Time"))]

###########################################

#PLOT 4
png(file = "plot4.png",width = 480, height = 480)
par(mfrow = c (2,2), mar = c(5,5,2,2))

#1,1
with(mydata2, plot(DateTime, Global_active_power, type = "o", pch = "", xlab = "", ylab = "Global Active Power"))

#1,2
with(mydata2, plot(DateTime, Voltage, type = "o", pch = "", xlab = "datetime", ylab = "Voltage"))

#2,1
with(mydata2, {
  plot(DateTime, Sub_metering_1, type = "n", pch = "", xlab = "", ylab = "Energy sub metering" )
  points(DateTime, Sub_metering_1, type = "o", pch = "" )
  points(DateTime, Sub_metering_2, type = "o", pch = "", col = "red")
  points(DateTime, Sub_metering_3, type = "o", pch = "", col = "blue")
  legend("topright", lty = c(1,1,1), col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.9,  bty = "n")
})

#2,2
with(mydata2, plot(DateTime, Global_reactive_power, type = "o", pch = "", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()