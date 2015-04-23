# Loads data if non-existent
if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot1.png", 
    width = 480, height = 480, 
    units = "px")
totalEmissions <- aggregate(NEI$Emissions, list(NEI$year), FUN = "sum")

plot(totalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions in the United States from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()


