## read data from directory
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

## Plotting the graph
plot(housing_sub$Global_active_power ~ housing_sub$Datetime, type="l", xlab = "", ylab="Global Active Power (kilowatts)")

## Copy the graph to a png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()