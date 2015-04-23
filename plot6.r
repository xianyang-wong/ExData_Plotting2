# Loads data if non-existent
if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}


# Subset data to Baltimore City and Los Angeles only
subsetNEI<-subset(NEI,fips =="24510" | fips=="06037")

library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

motor <- grep("motor", sccData$Short.Name, ignore.case = TRUE)
motor <- sccData[motor, ]
motorsubsetNEI <- subsetNEI[subsetNEI$SCC %in% motor$SCC, ]

g <- ggplot(motorsubsetNEI, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Comparison of Total Motor Vehicle Emissions\n in Baltimore City and Los Angeles County\n from 1999 to 2008") +
  scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))
dev.off()