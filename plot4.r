# Loads data if non-existent
if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot4.png", 
    width = 480, height = 480, 
    units = "px")

#Selecting for just coal combustion-related sources emissions
coal <- grep("coal", sccData$Short.Name, ignore.case = TRUE)
coal <- sccData[coal, ]
coalNEI <- NEI[NEI$SCC %in% coal$SCC, ]

totalcoalEmissions <- aggregate(coalNEI$Emissions, list(coalNEI$year), FUN = "sum")
# options(scipen=0)
# options(scipen=999)
plot(totalcoalEmissions, type = "l", xlab = "Year", 
     main = "Total Coal Combustion-related Emissions\n in the United States from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()