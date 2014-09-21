## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")


## Get rows for Baltimore city
data <- subset(NEI,fips=='24510')

## aggregate emissions by year
finalData <- aggregate(data[c("Emissions")],list(year=data$year),sum)

## plot aggregated data
png('plot2.png', width=480, height=480)

plot(finalData$year,finalData$Emissions,type = "l", main = "Total Emissions from PM2.5 in the Baltimore City",xlab = "Year", ylab = "Emissions")

dev.off()