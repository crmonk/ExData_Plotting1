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

#Plot 2
png(file = "plot2.png",width = 480, height = 480)
par(mfrow = c(1,1), mar = c(4,4,2,1)))
with(mydata2, plot(DateTime, Global_active_power, type = "o", pch = "", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()