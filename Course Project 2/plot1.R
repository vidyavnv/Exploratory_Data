## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")

## aggregate emissions by year
data <- aggregate(NEI[c("Emissions")],list(year=NEI$year),sum)

## plot aggregated data
png('plot1.png', width=480, height=480)

plot(data$year,data$Emissions,type = "l", main = "Total Emissions from PM2.5 in the US",xlab = "Year", ylab = "Emissions")

dev.off()