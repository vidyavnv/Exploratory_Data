## for ggplot function
library(ggplot2)

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SRC <- readRDS("./data/Source_Classification_Code.rds")

## grep values with 'vehicle' as a keyword
Mob <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T)

## get codes for those values
srcMob <- subset(SRC,SRC$EI.Sector %in% Mob, select=SCC)

#get data for Baltimore only
baltimore <- subset(NEI,fips== "24510")

## get rows matching those codes in baltimore data
baltimoreMob <- subset(baltimore,baltimore$SCC %in% srcMob$SCC)

## aggregate emissions by year
finalData <- aggregate(baltimoreMob[c("Emissions")],list(year= baltimoreMob$year),sum)

## plot data
png('plot5.png', width=480, height=480)

p <- ggplot(finalData,aes(x=year,y=Emissions)) + geom_point(alpha=.3) + geom_smooth(alpha=.2, size=1) + ggtitle("Emissions from motor vehicle sources in Baltimore")
print(p)

dev.off()