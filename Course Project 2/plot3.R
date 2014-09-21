## read data

library(ggplot2)
NEI <- readRDS("./data/summarySCC_PM25.rds")

## Get rows for Baltimore city
data <- subset(NEI,fips=='24510')

## aggregate emissions by year and type
finalData <- aggregate(data[c("Emissions")],list(type=data$type,year=data$year),sum)

## plot aggregated data
png('plot3.png', width=480, height=480)

p <- ggplot(finalData,aes(x=year,y=Emissions,color=type)) + geom_point(alpha=.3) + geom_smooth(alpha=.2, size=1, method="loess") + ggtitle("Total Emissions by Type in Baltimore City")

print(p)
dev.off()