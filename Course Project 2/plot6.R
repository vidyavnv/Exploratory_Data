## for ggplot function
library(ggplot2)

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SRC <- readRDS("./data/Source_Classification_Code.rds")

## grep values with 'vehicle' as a keyword
Mob <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T)

## get codes for those values
srcMob <- subset(SRC,SRC$EI.Sector %in% Mob, select=SCC)

#get data for Baltimore and LA only
baltimoreLA <- subset(NEI,fips == "24510"|fips == "06037")

## get rows matching those codes in baltimore and LA data
baltimoreLAMob <- subset(baltimoreLA,baltimoreLA$SCC %in% srcMob$SCC)

## aggregate emissions by year
finalData <- aggregate(baltimoreLAMob[c("Emissions")],list(fips = baltimoreLAMob$fips,year= baltimoreLAMob$year),sum)

finalData$city <- rep(NA, nrow(finalData))
finalData[finalData$fips == "06037", ][, "city"] <- "Los Angles County"
finalData[finalData$fips == "24510", ][, "city"] <- "Baltimore City"

## plot data
png('plot6.png', width=480, height=480)

p <- ggplot(finalData,aes(x=year,y=Emissions,colour=city)) + geom_point(alpha=.3) + geom_smooth(alpha=.2, size=1,method="loess") + ggtitle("Emissions from motor vehicle sources in Baltimore and LA")
print(p)

dev.off()