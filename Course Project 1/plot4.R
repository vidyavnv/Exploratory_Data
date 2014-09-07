### read data from directory
housing <-read.csv("./data/household_power_consumption.txt",header=TRUE,sep=";",quote = "\"",comment.char = "",stringsAsFactors=FALSE,na.strings="?",check.names=F)

## converting date from factor to Date type
housing$Date <- as.Date(housing$Date, format="%d/%m/%Y")

## subsetting data to have data from 2007-02-01 to 2007-02-02
housing_sub <- subset(housing,subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(housing)

## adding date and time together to get a new column datetime 
datetime <- paste(as.Date(housing_sub$Date), housing_sub$Time)
## adding datetime to housing_sub as new column Datetime
housing_sub$Datetime <- as.POSIXct(datetime)

## creating a matrix of plots 2X2
par(mfrow=c(2,2))

## plotting matrix of plots
with(housing_sub, {
	plot(Global_active_power ~ Datetime, type="l", xlab = "", ylab="Global Active Power")
	plot(Voltage ~ Datetime, type="l", xlab = "datetime", ylab="Voltage")
	plot(Sub_metering_1~Datetime,type="l",ylab="Energy sub metering",xlab="")
	lines(Sub_metering_2~Datetime,col="Red")
	lines(Sub_metering_3~Datetime,col="Blue")
	legend("topright", col=c("black","red","blue"),lty=1,lwd=2,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	plot(Global_reactive_power ~ Datetime, type="l", xlab = "datetime", ylab="Global_reactive_power")
})


## Copy the graph to a png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()