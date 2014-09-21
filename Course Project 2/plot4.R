## for ggplot
library(ggplot2)

## read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SRC <- readRDS("./data/Source_Classification_Code.rds")

## grep values with 'Coal' as a keyword
CC <- grep("Coal",SRC$EI.Sector,value=T,ignore.case=F)

## get codes for those values
srcCC <- subset(SRC,SRC$EI.Sector %in% CC, select=SCC)

## get rows matching those codes in NEI data
neiCC <- subset(NEI,NEI$SCC %in% srcCC$SCC)

## aggregate emissions by year
finalData <- aggregate(neiCC[c("Emissions")],list(year=neiCC$year),sum)

## plot data
png('plot4.png', width=480, height=480)

p <- ggplot(finalData,aes(x=year,y=Emissions)) + geom_point(alpha=.3) + geom_smooth(alpha=.2, size=1) + ggtitle("Emissions from coal combustion-related sources in US")

print(p)
dev.off()