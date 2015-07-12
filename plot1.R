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

##CLEANUP

#identify if there are any rows with "?"
numberCols <- mydata2[,!(names(mydata2) %in% c("Time", "DateTime", "Date"))]
qmarks <- apply(numberCols, 1, function(x) "?")
isQmark <- numberCols == qmarks
#Use sum by columns to see if there are any TRUE values (== "?")
qmarkResult <- apply(isQmark, 2, function(x) sum(x[!is.na(x)]))
qmarkResult
#Result is that all of the columns sum to zero, so there are no "?" in mydata2
#cleanup temp variables
numberCols <- NULL
gc()

###########################################

##PLOT 1
png(file = "plot1.png",width = 480, height = 480)
par(mfrow = c(1,1), mar = c(4,4,2,1)))
hist(as.numeric(mydata2$Global_active_power), main = "Global Active Power", col = "red", xlab= "Global Active Power (kilowatts)")
#export to PNG
dev.off()
